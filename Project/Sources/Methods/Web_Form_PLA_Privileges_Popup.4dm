//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04/04/20, 20:38:22
// ----------------------------------------------------
// Method: Web_Form_PLA_Privileges_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($html; $0)

$html:=""

$html:=$html+"<div id=\"iw_form_popup_privileges\">"
$html:=$html+"<div id=\"iw_form_popup_child_privileges\">"

$html:=$html+"<div class=\"portlet box blue  \" >"

$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-user-secret\"></i><span id=\"titre_popup_privileges\"></span>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"

//-----------------------------------------------------------------//

$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"

$html:=$html+Web_Form_PLA_Privileges_Ligne
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

//-----------------------------------------------------------------//

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html