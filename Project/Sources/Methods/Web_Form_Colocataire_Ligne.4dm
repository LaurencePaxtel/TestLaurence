//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 11-02-19, 05:41:30
// ----------------------------------------------------
// Method: Web_Form_Colocataire_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(SCRIPT)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="colocataire_ligne"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="colocataire_ligne"
$TB_FORM{0}{6}:="iw_piece_ligne"

C_TEXT:C284($disabled)
$disabled:=""

PARAM_MANDATORY_FIELDS:="loc_colocataire;loc_colocataire_id"


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="loc_colocataire"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Colocataire"
$TB_HTML{$o}{6}:="loc_colocataire"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne_colocataire"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne_colocataire"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="loc_colocataire_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="loc_colocataire_id"
$TB_HTML{$o}{7}:=""


ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)

