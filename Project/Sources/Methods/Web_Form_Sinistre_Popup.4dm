//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 10-01-19, 22:08:18
// ----------------------------------------------------
// Method: Web_Form_Sinistre_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($html; $0; $post_action; $1; $get_action; $2)
C_BOOLEAN:C305($lk_gb)

$post_action:=$1
$get_action:=$2
$lk_gb:=$3

$html:=""

$html:=$html+"<div id=\"iw_form_popup\"  class=\"iw_form_popup_gb\">"
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

$html:=$html+Web_Form_Sinistre_Ligne($post_action; $get_action; $lk_gb)
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

//-----------------------------------------------------------------//

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html