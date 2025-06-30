//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 08/12/18, 00:40:03
// ----------------------------------------------------
// Méthode : Web_Form_Proprietaires
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284(SCRIPT; $UID; $disabled)
C_LONGINT:C283($o)
C_POINTER:C301($user_type)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$user_type:=$1
$disabled:=""
RECORD_ACT_EDIT:=True:C214

$action:=WEB_UTL_GET_PARAMS("action")
$UID:=WEB_UTL_GET_PARAMS("UID")
$actionm:=WEB_UTL_GET_PARAMS("actionm")

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=proprietaires"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="proprietaires"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="proprietaires"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_LAST_NAME
$TB_HTML{$o}{6}:="search_nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start iw_data_column_0"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_prenom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_FIRST_NAME
$TB_HTML{$o}{6}:="search_prenom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_1"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_telephone"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_NUM_TELEPHONE
$TB_HTML{$o}{6}:="search_telephone"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_2"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_email"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Email"
$TB_HTML{$o}{6}:="search_email"
$TB_HTML{$o}{7}:="fdp_span3  search span7 iw_data_column_3"

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
$TB_HTML{$o}{3}:="method"
$TB_HTML{$o}{4}:="GET"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="method"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

If (Count parameters:C259=1)
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	COPY ARRAY:C226($TB_HTML; $2->)
End if 