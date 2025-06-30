//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 14-12-18, 15:13:07
// ----------------------------------------------------
// Method: Web_Form_IRL_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($o)

C_TEXT:C284($html; $0)

$html:=""

$html:=$html+"<div id=\"iw_form_popup\">"
$html:=$html+"<div id=\"iw_form_popup_child\">"

$html:=$html+"<div class=\"portlet box blue tabbable iw_notes_sp\" >"

$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-edit\"></i><span id=\"titre_popup\"></span>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"

//-----------------------------------------------------------------//

$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"
$html:=$html+Web_Form_IRL(->$o)
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

//-----------------------------------------------------------------//

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html