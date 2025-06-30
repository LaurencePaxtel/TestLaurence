//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 12/06/2020, 07:49:00
// ----------------------------------------------------
// Method: Web_Form_GI_STK_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(SCRIPT)
C_LONGINT:C283($o)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$o:=0

RECORD_ACT_EDIT:=True:C214
FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="form_stkm"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="form_stkm"
$TB_FORM{0}{6}:="iw_piece_ligne"

C_TEXT:C284($disabled)
$disabled:=""

PARAM_MANDATORY_FIELDS:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Date:7)+";"+UTL_Field_Name(->[Stock_Mouvements:114]STKM_Heure:8)+";"+UTL_Field_Name(->[Stock_Mouvements:114]STKM_Quantite:6)

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Date:7)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date du mouvement"
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Date:7)
$TB_HTML{$o}{7}:="fdp_span3  span7 datepicker iw_cg_width_half "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Heure:8)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Heure"
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Heure:8)
$TB_HTML{$o}{7}:="fdp_span3  span7 timepicker iw_cg_width_half "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Quantite:6)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Quantité"
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Quantite:6)
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Motif:11)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Motif"
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Motif:11)
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="textarea"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Description:10)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Description"
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Stock_Mouvements:114]STKM_Description:10)
$TB_HTML{$o}{7}:="iw_margin_bottom_10px iw_textarea_rows_5 iw_cg_width_full "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)


