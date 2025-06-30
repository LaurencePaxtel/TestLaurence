//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 08:13:23
// ----------------------------------------------------
// Method: Web_Form_PLA_Settings_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($html; $0)

$html:=""

$html:=$html+"<div id=\"iw_form_popup_config\">"
$html:=$html+"<div id=\"iw_form_popup_child_config\">"

$html:=$html+"<div class=\"portlet box blue  \" >"

$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-cogs\"></i><span id=\"titre_popup_config\"></span>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"

//-----------------------------------------------------------------//

$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"

$html:=$html+Web_Form_PLA_Settings_Ligne
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

//-----------------------------------------------------------------//

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html