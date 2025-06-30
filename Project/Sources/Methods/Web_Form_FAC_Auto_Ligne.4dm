//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25-02-19, 11:29:45
// ----------------------------------------------------
// Method: Web_Form_FAC_Auto_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)

C_LONGINT:C283($o)

C_TEXT:C284(SCRIPT)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

FIX_DATE_FORMAT:="dd/mm/yyyy"
RECORD_ACT_EDIT:=True:C214

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="facture_ligne"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="facture_ligne"
$TB_FORM{0}{6}:="iw_piece_ligne"

PARAM_MANDATORY_FIELDS:=""
PARAM_MANDATORY_FIELDS:="fac_auto_mois"

$o:=$o+1
$TB_HTML{$o}{1}:="iw-datepicker"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="fac_auto_mois"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Veuillez choisir le mois"
$TB_HTML{$o}{6}:="fac_auto_mois"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start iw_cg_width_full "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_fac_auto_ligne"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_fac_auto_ligne"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="facl_type"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="facl_type"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="param_separation_charges"
$TB_HTML{$o}{4}:=SO_FAC_GI_Separer_Charges_Str
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="param_separation_charges"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)