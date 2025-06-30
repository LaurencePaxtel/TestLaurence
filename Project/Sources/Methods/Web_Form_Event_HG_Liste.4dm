//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26/04/20, 08:36:46
// ----------------------------------------------------
// Method: Web_Form_Event_HG_Liste
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($html; $0)

ARRAY TEXT:C222($TB_HTML; 100; 15)
C_LONGINT:C283($o)

$o:=0

$html:="<div class=\"control-group parent_btn_create_fiche \">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="button"
$TB_HTML{$o}{3}:="btn_fiche_hg_create"
$TB_HTML{$o}{4}:="Création fiche"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="btn_fiche_hg_create"
$TB_HTML{$o}{7}:="iw_end_div_parent iw_cg_one_groupe_end iw_cg_width_one_third btn iw_icon_new iw_form_btns"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"<div id=\"event_fiches_hg_liste\">"
$html:=$html+"<div id=\"event_hg_liste\" class=\"iw_table_notification fdp_resp_table  iw-alternance-only\">"
$html:=$html+"<div class=\"table iw_data_table table table-striped table-advance\">"
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html

