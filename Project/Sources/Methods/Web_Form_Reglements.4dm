//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02-02-19, 09:56:19
// ----------------------------------------------------
// Method: Web_Form_Reglements
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(SCRIPT; $disabled)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)

$disabled:=""
RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=reglements"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="reglements"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="reglements"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_date_du"
$TB_HTML{$o}{4}:=String:C10(Current date:C33(*))
$TB_HTML{$o}{5}:="Date du"
$TB_HTML{$o}{6}:="search_date_du"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker iw_data_column_1 "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_date_au"
$TB_HTML{$o}{4}:=String:C10(Current date:C33(*))
$TB_HTML{$o}{5}:="Date au"
$TB_HTML{$o}{6}:="search_date_au"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker iw_data_column_2"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_button_icon"
$TB_HTML{$o}{2}:="reset"
$TB_HTML{$o}{3}:="btn_left"
$TB_HTML{$o}{4}:="<i class=\"fa fa-arrow-circle-left\"></i>"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="btn_left"
$TB_HTML{$o}{7}:="iw_cg_btn_icon fdp_Button iw_btn_icon_only fdp-btn-green iw_margin_left_5px iw_btn_icon icon_next"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_button_icon"
$TB_HTML{$o}{2}:="reset"
$TB_HTML{$o}{3}:="btn_next"
$TB_HTML{$o}{4}:="<i class=\"fa fa-arrow-circle-right\"></i>"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="btn_next"
$TB_HTML{$o}{7}:="iw_cg_btn_icon fdp_Button iw_btn_icon_only fdp-btn-green iw_margin_left_5px iw_btn_icon icon_next"

//$o:=$o+1
//$TB_HTML{$o}{1}:="input"
//$TB_HTML{$o}{2}:="text"
//$TB_HTML{$o}{3}:="search_destinataire"
//$TB_HTML{$o}{4}:=""
//$TB_HTML{$o}{5}:="Destinataire"
//$TB_HTML{$o}{6}:="search_destinataire"
//$TB_HTML{$o}{7}:="span7 search fdp_placeholder"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_locataire"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Locataire"
$TB_HTML{$o}{6}:="search_locataire"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_3"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_montant"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant"
$TB_HTML{$o}{6}:="search_montant"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_4"

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

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)



