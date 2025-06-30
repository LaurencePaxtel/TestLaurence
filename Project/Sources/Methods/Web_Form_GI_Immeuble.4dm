//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20/05/20, 08:45:05
// ----------------------------------------------------
// Method: Web_Form_GI_Immeuble
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(SCRIPT)
C_LONGINT:C283($o)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="gi_immeuble"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="gi_immeuble"
$TB_FORM{0}{6}:="iw_immeuble_ligne"

C_TEXT:C284($disabled)
$disabled:=""

PARAM_MANDATORY_FIELDS:="imm_nom"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="imm_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom"
$TB_HTML{$o}{6}:="imm_nom"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_full "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_fields_immeuble"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_fields_immeuble"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)


