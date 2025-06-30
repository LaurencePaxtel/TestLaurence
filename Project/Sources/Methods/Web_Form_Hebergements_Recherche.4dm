//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 02:57:39
// ----------------------------------------------------
// Méthode : Web_Form_Hebergement_Recherche
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284($disabled; $action; $UID; $actionm)
C_LONGINT:C283($o)
C_TEXT:C284($UID)
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

$TB_FORM{0}{1}:="GL?action=liste-usagers"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="locataires"
$TB_FORM{0}{4}:=FIX_PARAM_ACTION
$TB_FORM{0}{5}:="locataires"
$TB_FORM{0}{6}:=LANG_TXT_CREATE_ACCCOUNT

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_LAST_NAME
$TB_HTML{$o}{6}:="nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "+$disabled+" "+class_invalid_last_name

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="prenom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_FIRST_NAME
$TB_HTML{$o}{6}:="prenom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+$disabled+" "+class_invalid_first_name

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="date_naissance"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_DATE_NAISSANCE
$TB_HTML{$o}{6}:="date_naissance"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="lien_famille"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_LIEN_FAMILLE
$TB_HTML{$o}{6}:="lien_famille"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "+$disabled+" "+class_invalid_lien_famille

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="telephone"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_NUM_TELEPHONE
$TB_HTML{$o}{6}:="telephone"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+$disabled+" "+class_invalid_first_name

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="filtre_jour"
$TB_HTML{$o}{4}:="<span hidden>Jour</span"
$TB_HTML{$o}{5}:="<span hidden>Jour</span"
$TB_HTML{$o}{6}:="filtre_jour"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres fdp_row_start "

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="filtre_nuit"
$TB_HTML{$o}{4}:="<span hidden>Prestation</span"
$TB_HTML{$o}{5}:="<span hidden>Prestation</span"
$TB_HTML{$o}{6}:="filtre_nuit"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="filtre_jour_nuit"
$TB_HTML{$o}{4}:="<span hidden>Jour + Prestation</span"
$TB_HTML{$o}{5}:="<span hidden>Jour + Prestation</span"
$TB_HTML{$o}{6}:="filtre_jour_nuit"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="utilisateur"
$TB_HTML{$o}{4}:=w_userNom
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="utilisateur"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="cle"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="cle"
$TB_HTML{$o}{7}:=""

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
$TB_HTML{$o}{3}:="mandatory"
$TB_HTML{$o}{4}:="nom;prenom;date_naissance"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="hb_referenceid"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_referenceid"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="hegerges_ids"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hegerges_ids"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="record_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="record_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="id_selected"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="id_selected"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="cle_selected"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="cle_selected"
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
	C_POINTER:C301($1)
	COPY ARRAY:C226($TB_HTML; $2->)
End if 