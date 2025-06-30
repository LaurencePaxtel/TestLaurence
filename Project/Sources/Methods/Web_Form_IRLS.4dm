//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 13-12-18, 09:25:21
// ----------------------------------------------------
// Method: Web_Form_IRLS
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284($trimestre; SCRIPT)
C_LONGINT:C283($o)
C_POINTER:C301($user_type)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$user_type:=$1
RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=irl"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="irl"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="irl"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_annee"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Année"
$TB_HTML{$o}{6}:="search_annee"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"

$trimestre:=";;|1_1er trimestre|2_2ème trimestre|3_3ème trimestre|4_4ème trimestre"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="search_trimestre"
$TB_HTML{$o}{4}:=$trimestre
$TB_HTML{$o}{5}:="Trimestre de référence"
$TB_HTML{$o}{6}:="search_trimestre"
$TB_HTML{$o}{7}:="fdp_span3 span7"

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
	C_POINTER:C301($2)
	
	COPY ARRAY:C226($TB_HTML; $2->)
End if 