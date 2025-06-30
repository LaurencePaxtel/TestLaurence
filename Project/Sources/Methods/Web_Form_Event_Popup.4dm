//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 28/03/20, 04:19:48
// ----------------------------------------------------
// Method: Web_Form_Event_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($html; $0)

$html:=""

$html:=$html+"<div id=\"iw_form_popup\">"
$html:=$html+"<div id=\"iw_form_popup_child_event\">"

$html:=$html+"<div class=\"portlet box blue tabbable \" >"

$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-edit\"></i><span id=\"titre_popup\"></span>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"

//-----------------------------------------------------------------  //
$html:=$html+"<div class=\"tabbable portlet-tabs\">"
$html:=$html+"<ul class=\"nav nav-tabs\">"
$html:=$html+"<li class=\"\"><a href=\"#tab-2\" data-toggle=\"tab\">Liste des fiches</a></li>"
$html:=$html+"<li class=\"active\"><a href=\"#tab-1\" data-toggle=\"tab\">Détails</a></li>"
$html:=$html+"</ul>"
$html:=$html+"<div class=\"tab-content\">"

//-----------------------------------------------------------------  //
$html:=$html+"<div class=\"tab-pane active\" id=\"tab-1\">"
//-----------------------------------------------------------------  //
$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"
$html:=$html+Web_Form_Event_Ligne
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"
//-----------------------------------------------------------------  //
$html:=$html+"</div>"
//-----------------------------------------------------------------  //


//-----------------------------------------------------------------  //
$html:=$html+"<div class=\"tab-pane\" id=\"tab-2\">"
//-----------------------------------------------------------------  //
$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"
$html:=$html+Web_Form_Event_HG_Liste
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"
//-----------------------------------------------------------------  //
$html:=$html+"</div>"
//-----------------------------------------------------------------  //
$html:=$html+"</div>"
$html:=$html+"</div>"
//**tabs

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html