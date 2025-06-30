//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 17-01-19, 16:12:44
// ----------------------------------------------------
// Method: Web_Form_Doc_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)

C_TEXT:C284($html)

$html:=$html+"<div id=\"iw_form_popup\">"
$html:=$html+"<div id=\"iw_form_popup_child\">"

$html:=$html+"<div class=\"portlet box blue  \" >"

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
$html:=$html+Web_Doc_Form(->[Locations:84]ID:1; ->[Locations:84]; True:C214)
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

//-----------------------------------------------------------------//

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html