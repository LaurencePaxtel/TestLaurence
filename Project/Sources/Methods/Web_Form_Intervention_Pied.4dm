//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 04/06/2020, 15:43:30
// ----------------------------------------------------
// Method: Web_Form_Intervention_Pied
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($HTML_CONTENT; FIX_DATE_FORMAT)

ARRAY TEXT:C222($TB_HTML; 150; 15)
C_LONGINT:C283($o)
$o:=0

WEB_CHAMP_Saisissable:=""

$HTML_CONTENT:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

PARAM_MANDATORY_FIELDS:=""

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_pied well\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_third\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   iw_third  iw_side_by_side\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Total HT"
$TB_HTML{$o}{6}:="Total HT"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Intervention:108]INT_Total_HT:7)
$TB_HTML{$o}{4}:=String:C10([Intervention:108]INT_Total_HT:7)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Intervention:108]INT_Total_HT:7)
$TB_HTML{$o}{7}:="span7 search readonly"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   iw_third  iw_side_by_side\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Total TVA"
$TB_HTML{$o}{6}:="Total TVA"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Intervention:108]INT_Total_TVA:8)
$TB_HTML{$o}{4}:=String:C10([Intervention:108]INT_Total_TVA:8)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Intervention:108]INT_Total_TVA:8)
$TB_HTML{$o}{7}:="span7 search readonly"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group    iw_third iw_side_by_side\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Total TTC"
$TB_HTML{$o}{6}:="Total TTC"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Intervention:108]INT_Total_TTC:9)
$TB_HTML{$o}{4}:=String:C10([Intervention:108]INT_Total_TTC:9)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Intervention:108]INT_Total_TTC:9)
$TB_HTML{$o}{7}:="span7 search readonly"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"


$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group    iw_third iw_side_by_side\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Coût matériel TTC"
$TB_HTML{$o}{6}:="Coût matériel TTC"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Intervention:108]INT_EQU_Total_TTC:10)
$TB_HTML{$o}{4}:=String:C10([Intervention:108]INT_EQU_Total_TTC:10)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Intervention:108]INT_EQU_Total_TTC:10)
$TB_HTML{$o}{7}:="span7 search readonly"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group    iw_third iw_side_by_side\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Coût prestation TTC"
$TB_HTML{$o}{6}:="Coût prestation TTC"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[Intervention:108]INT_Prestation_Total_TTC:14)
$TB_HTML{$o}{4}:=String:C10([Intervention:108]INT_Prestation_Total_TTC:14)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:=UTL_Field_Name(->[Intervention:108]INT_Prestation_Total_TTC:14)
$TB_HTML{$o}{7}:="span7 search readonly"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"


$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$0:=$HTML_CONTENT