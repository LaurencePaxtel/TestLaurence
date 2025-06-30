//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04/04/20, 08:44:21
// ----------------------------------------------------
// Method: Web_Form_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2)

C_TEXT:C284($name; $css_class_icon; $html)
C_POINTER:C301($content_html)
C_BOOLEAN:C305($use_boutons)


Web_UTL_Add_CSS("popup_simple")

$name:=$1
$content_html:=$2

$css_class_icon:="fa-file"

If (Count parameters:C259>2)
	$use_boutons:=$3
End if 

Case of 
	: ($name="basedoclist")
		$css_class_icon:="fa-file-pdf-o"
End case 

$html:=$html+"<div id=\"iw_form_popup_"+$name+"\" class=\"iw_form_popup_gb\">"
$html:=$html+"<span class=\"helper\"></span>"
$html:=$html+"<div id=\"iw_form_popup_child_"+$name+"\">"

//-----------------------------------------------------------------//
$html:=$html+"<div class=\"portlet box blue\">"
$html:=$html+"<div class=\"portlet-title\">"

$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa "+$css_class_icon+"\"></i><span id=\"titre_popup_"+$name+"\"></span>"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"

//-----------------------------------------------------------------//
$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"

$html:=$html+$content_html->

$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"
//-----------------------------------------------------------------//

$html:=$html+"</div>"
$html:=$html+"</div>"
//-----------------------------------------------------------------//

If ($use_boutons)
	$html:=$html+"<div class=\"iw_confirm_buttons\">"
	$html:=$html+"<button type=\"button\" id=\"btn_popup_save\" class=\"btn btn-blue\">Valider</button>"
	$html:=$html+"<button type=\"button\" id=\"btn_popup_close\" class=\"btn btn-default\">Annuler</button>"
	$html:=$html+"</div>"
End if 

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html