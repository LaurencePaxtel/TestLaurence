//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02-05-19, 08:50:39
// ----------------------------------------------------
// Method: Web_Form_ETL_Popup
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)

C_TEXT:C284($html; $post_action; $get_action; $param_1)
C_LONGINT:C283($id_location)

$post_action:=$1
$get_action:=$2
$id_location:=$3

If (Count parameters:C259>3)
	$param_1:="_"+$4
End if 

$html:=$html+"<div id=\"iw_form_popup_etl"+$param_1+"\">"
$html:=$html+"<div id=\"iw_form_popup_child_etl"+$param_1+"\">"

$html:=$html+"<div class=\"portlet box blue\" >"

$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-edit\"></i><span id=\"titre_popup_etl"+$param_1+"\"></span>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"

//-----------------------------------------------------------------//

$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"

If ($param_1="")
	$html:=$html+Web_Form_ETL_Pieces($post_action; $get_action; $id_location)
Else 
	$html:=$html+Web_Form_ETL_Comparatif($id_location)
End if 

$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

//-----------------------------------------------------------------//
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

// Modifié par : Scanu Rémy (11/08/2022)
// Ajout iframe du document 4DWP
If (Count parameters:C259<4)
	$html:=$html+"<div id=\"4DWriteDiv\" style=\"width: 100%; text-align: center;\">"
	$html:=$html+"<iframe id=\"4DWriteIframe\" height=\"700\" src=\"\" style=\"\">"
	$html:=$html+"</iframe>"
	$html:=$html+"</div>"
End if 

$0:=$html