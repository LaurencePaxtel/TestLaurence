//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 08/12/18, 00:44:15
// ----------------------------------------------------
// Méthode : Web_Form_Proprietaire_Popup
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_LONGINT:C283($o)

C_TEXT:C284($html; $0)

$html:=""

$html:=$html+"<div id=\"iw_form_popup\">"
$html:=$html+"<div id=\"iw_form_popup_child\">"

$html:=$html+"<div class=\"portlet box blue tabbable iw_notes_sp\" >"

$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-edit\"></i><span id=\"titre_popup\"></span>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"


//***************************************************************************************************//

$html:=$html+"<div class=\"tabbable portlet-tabs\">"
$html:=$html+"<ul class=\"nav nav-tabs\">"
$html:=$html+"<li class=\"\"><a href=\"#tab-3\" data-toggle=\"tab\">Coordonnées bancaires</a></li>"
$html:=$html+"<li class=\"\"><a href=\"#tab-2\" data-toggle=\"tab\">Biens</a></li>"
$html:=$html+"<li class=\"active\"><a href=\"#tab-1\" data-toggle=\"tab\">Détails</a></li>"
$html:=$html+"</ul>"
$html:=$html+"<div class=\"tab-content\">"

$html:=$html+"<div class=\"tab-pane active\" id=\"tab-1\">"
$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"


$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"
$html:=$html+Web_Form_Proprietaire(->$o)
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"
$html:=$html+Web_Form_Adresse(->[Proprietaires:83]ID:1)
$html:=$html+"</div>"
$html:=$html+"</div>"



$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"tab-pane\" id=\"tab-2\">"
$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"
$html:=$html+Web_Form_Liste_Biens
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"tab-pane\" id=\"tab-3\">"
$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"<div class=\"fdp_line\">"
$html:=$html+Web_Form_Info_Bancaires
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"


//***************************************************************************************************//

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html