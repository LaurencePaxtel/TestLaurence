//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07-02-19, 08:43:40
// ----------------------------------------------------
// Method: Web_Form_Relances
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284(SCRIPT; $disabled)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)
C_POINTER:C301($1; $user_type)

$user_type:=$1
$disabled:=""
RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=relances"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="relances"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="relances"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_date"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date du relance"
$TB_HTML{$o}{6}:="search_date"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_destinataire"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Destinataire"
$TB_HTML{$o}{6}:="search_destinataire"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="search_destinataire_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="search_destinataire_id"
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
$TB_HTML{$o}{3}:="method"
$TB_HTML{$o}{4}:="GET"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="method"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

If (Count parameters:C259=1)
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	C_POINTER:C301($1)
	COPY ARRAY:C226($TB_HTML; $2->)
End if 



