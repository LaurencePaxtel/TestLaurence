//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 08/12/18, 02:00:13
// ----------------------------------------------------
// Méthode : Web_Form_Proprietaire
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284(SCRIPT; $UID)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)
C_POINTER:C301($1; $id)

$id:=$1

RECORD_ACT_EDIT:=True:C214

$action:=WEB_UTL_GET_PARAMS("action")
$UID:=WEB_UTL_GET_PARAMS("UID")
$actionm:=WEB_UTL_GET_PARAMS("actionm")

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="usager"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="usager"
$TB_FORM{0}{6}:=""


C_TEXT:C284($disabled)
$disabled:=""
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pro_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_LAST_NAME
$TB_HTML{$o}{6}:="pro_nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pro_prenom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_FIRST_NAME
$TB_HTML{$o}{6}:="pro_prenom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pro_email"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Email"
$TB_HTML{$o}{6}:="pro_email"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pro_telephone"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_NUM_TELEPHONE
$TB_HTML{$o}{6}:="pro_telephone"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "



$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="id"
$TB_HTML{$o}{4}:=String:C10($id->)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory"
$TB_HTML{$o}{4}:="hb_nom;hb_prenom;hb_datenele"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

If (Count parameters:C259=1)
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	C_POINTER:C301($1)
	COPY ARRAY:C226($TB_HTML; $2->)
End if 
