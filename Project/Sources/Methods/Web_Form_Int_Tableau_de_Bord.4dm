//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 26/10/18, 21:13:37
// ----------------------------------------------------
// Méthode : Web_Form_Int_Tableau_de_Bord
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284($UID; $action; $actionm)
C_LONGINT:C283($o)
C_POINTER:C301($user_type)

C_TEXT:C284(SCRIPT; class_invalid_password; class_invalid_email; class_invalid_first_name; class_invalid_last_name; class_invalid_communication; class_invalid_email)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$user_type:=$1

RECORD_ACT_EDIT:=True:C214

$action:=WEB_UTL_GET_PARAMS("action")
$UID:=WEB_UTL_GET_PARAMS("UID")
$actionm:=WEB_UTL_GET_PARAMS("actionm")

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="USR?action=add&user=agent"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="profile"
$TB_FORM{0}{4}:=FIX_PARAM_ACTION
$TB_FORM{0}{5}:="profile"
$TB_FORM{0}{6}:=LANG_TXT_CREATE_ACCCOUNT

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="date_du"
$TB_HTML{$o}{4}:=String:C10(Current date:C33(*))
$TB_HTML{$o}{5}:=LANG_TXT_DATE_DU
$TB_HTML{$o}{6}:="date_du"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="date_au"
$TB_HTML{$o}{4}:=String:C10(Current date:C33(*))
$TB_HTML{$o}{5}:=LANG_TXT_DATE_AU
$TB_HTML{$o}{6}:="date_au"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="date_du_premier_contact"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_DATE_DU+" (premier contact)"
$TB_HTML{$o}{6}:="date_du_premier_contact"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="date_au_premier_contact"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_DATE_AU+" (premier contact)"
$TB_HTML{$o}{6}:="date_au_premier_contact"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7"

$o:=$o+1
$TB_HTML{$o}{1}:="iw-popup-simple"
$TB_HTML{$o}{2}:="iw-popup-simple"
$TB_HTML{$o}{3}:="centres_list"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_CENTRE
$TB_HTML{$o}{6}:="centres_list"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start iw-popup-btn-delete iw_read_only"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="telephone_numero"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_TELEPHONE_NUMERO
$TB_HTML{$o}{6}:="telephone_numero"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_LAST_NAME
$TB_HTML{$o}{6}:="nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="lien_famille"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_LIEN_FAMILLE
$TB_HTML{$o}{6}:="lien_famille"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"

/*
$o:=$o+1
$TB_HTML{$o}{1}:="iw-popup"
$TB_HTML{$o}{2}:="iw-popup"
$TB_HTML{$o}{3}:="autres_criteres"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_AUTRES_CRITERES
$TB_HTML{$o}{6}:="criteres"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_read_only"
*/

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="filtre_jour"
$TB_HTML{$o}{4}:="<span hidden>Jour</span"
$TB_HTML{$o}{5}:="<span hidden>Jour</span"
$TB_HTML{$o}{6}:="filtre_jour"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres fdp_row_start"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio_2"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="filtre_jour_nuit"
$TB_HTML{$o}{4}:="Prestations"
$TB_HTML{$o}{5}:="Prestations"
$TB_HTML{$o}{6}:="filtre_nuit"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio_2"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="filtre_jour_nuit"
$TB_HTML{$o}{4}:="Hébergements"
$TB_HTML{$o}{5}:="Hébergements"
$TB_HTML{$o}{6}:="filtre_jour"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio_2"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="filtre_jour_nuit"
$TB_HTML{$o}{4}:="Toutes"
$TB_HTML{$o}{5}:="Toutes"
$TB_HTML{$o}{6}:="filtre_jour_nuit"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:="Fiche unique"
$TB_HTML{$o}{5}:="Fiche unique"
$TB_HTML{$o}{6}:="filtre_fiche_unique"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="UID"
$TB_HTML{$o}{4}:=String:C10([HeBerge:4]ID:65)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="UID"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="method"
$TB_HTML{$o}{4}:="GET"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="method"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="action"
$TB_HTML{$o}{4}:=$action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="action"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

If (Count parameters:C259=1)
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	COPY ARRAY:C226($TB_HTML; $2->)
End if 