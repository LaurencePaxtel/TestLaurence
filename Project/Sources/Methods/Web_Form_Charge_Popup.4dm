//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 27-01-19, 09:07:02
// ----------------------------------------------------
// Method: Web_Form_Charge_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($html; $post_action; $get_action)
C_BOOLEAN:C305($lk_gb)


$post_action:=$1
$get_action:=$2
$lk_gb:=$3

$html:=""

$html:=$html+"<div id=\"iw_form_popup_charge\" class=\"iw_form_popup_gb\">"
$html:=$html+"<div id=\"iw_form_popup_child_charge\">"

$html:=$html+"<div class=\"portlet box blue  \" >"

$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-edit\"></i><span id=\"titre_popup_charge\"></span>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"

//-----------------------------------------------------------------//

$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"

$html:=$html+Web_Form_Charge_Ligne($post_action; $get_action; $lk_gb)
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

//-----------------------------------------------------------------//

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html