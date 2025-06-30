//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 22-12-18, 08:39:32
// ----------------------------------------------------
// Method: Web_Form_Facture_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $type_popup)

C_LONGINT:C283($o)

C_TEXT:C284($html; $0)

$type_popup:=$1

$html:=""

$html:=$html+"<div id=\"iw_form_popup"+$type_popup+"\">"
$html:=$html+"<div id=\"iw_form_popup_child"+$type_popup+"\">"

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
$html:=$html+Web_Form_Facture_Ligne(->$o; $type_popup)
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

//-----------------------------------------------------------------//

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html