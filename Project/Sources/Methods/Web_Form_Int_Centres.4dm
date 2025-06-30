//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 30/10/18, 18:40:25
// ----------------------------------------------------
// Méthode : Web_Form_Int_Centres
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)

C_TEXT:C284($action; $UID; $actionm)
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
$TB_HTML{$o}{3}:="datedu"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_DATE_DU
$TB_HTML{$o}{6}:="datedu"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="dateau"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_DATE_AU
$TB_HTML{$o}{6}:="dateau"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="centre"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_CENTRE_NOM
$TB_HTML{$o}{6}:="centre"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="complet"
$TB_HTML{$o}{4}:="Choix du statut;;|Oui_Oui"+"|Non_Non"
$TB_HTML{$o}{5}:="Complet"
$TB_HTML{$o}{6}:="complet"
$TB_HTML{$o}{7}:="span7 search"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="typegestion"
$TB_HTML{$o}{4}:="Choix du type de gestion;;|Location_Location"+"|Sous location_Sous location|Hébergement_Hébergement"
$TB_HTML{$o}{5}:="Type gestion"
$TB_HTML{$o}{6}:="typegestion"
$TB_HTML{$o}{7}:="span7 search"

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