//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 30/06/19, 23:46:29
// ----------------------------------------------------
// Method: Web_HTML_Portlet
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($type; $1; $titre; $2; $css_class; $3; $html)

$type:=$1
$titre:=$2
$css_class:=$3
$html:=""

Case of 
	: ($type="start")
		
		$html:=$html+"<div class=\"portlet box blue "+$css_class+" \" >"
		
		$html:=$html+"<div class=\"portlet-title \">"
		$html:=$html+"<div class=\"caption\">"
		$html:=$html+"<i class=\"\"></i><span id=\"titre_popup_charge\">"+$titre+"</span>"
		$html:=$html+"</div>"
		$html:=$html+"</div>"
		
		$html:=$html+"<div class=\"portlet-body form\">"
		
		//-----------------------------------------------------------------//
		
		$html:=$html+"<div class=\"clearfix\">"
		$html:=$html+"<div class=\"col100\">"
		$html:=$html+"<div class=\"fdp_line\">"
		
	: ($type="end")
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
		$html:=$html+"</div>"
		//-----------------------------------------------------------------//
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
		
		
	Else 
		
End case 

$0:=$html