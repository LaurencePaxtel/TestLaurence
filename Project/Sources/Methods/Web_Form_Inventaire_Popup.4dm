//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 05-05-19, 08:10:51
// ----------------------------------------------------
// Method: Web_Form_Inventaire_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($html; $0; $post_action; $1; $get_action; $2)

$post_action:=$1
$get_action:=$2


$html:=""

$html:=$html+"<div id=\"iw_form_popup_inventaire\"  class=\"iw_form_popup_gb\">"
$html:=$html+"<div id=\"iw_form_popup_child_inventaire\">"

$html:=$html+"<div class=\"portlet box blue  \" >"

$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-edit\"></i><span id=\"titre_popup_inventaire\"></span>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"

//-----------------------------------------------------------------//

$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"

$html:=$html+Web_Form_Inventaire_Ligne($post_action; $get_action)
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

//-----------------------------------------------------------------//

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html