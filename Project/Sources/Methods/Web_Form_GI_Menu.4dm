//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 05/06/2020, 09:36:08
// ----------------------------------------------------
// Method: Web_Form_GI_Menu
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)

C_TEXT:C284($html)

UTL_Add_Script("gl_main")

$html:="<div class=\"btn-group btn-group-vertical iw_btns_sidebar\">"
$html:=$html+"<button type=\"button\" id=\"btn_sb_toggle\" class=\"sb_btn_toggle\"><i class=\"fa fa-angle-double-left\"></i></button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_locataire_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_locataire_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Locataire"
$html:=$html+"<a  id=\"btn_sb_gi_locataire_l\" href=\"#\" class=\"btn_right\"><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_equipement_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_equipement_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Équipement"
$html:=$html+"<a  id=\"btn_sb_gi_equipement_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_intervention_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_intervention_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Intervention"
$html:=$html+"<a  id=\"btn_sb_gi_intervention_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_sinistre_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_sinistre_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Sinistre"
$html:=$html+"<a  id=\"btn_sb_gi_sinistre_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_charge_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_charge_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Charge"
$html:=$html+"<a  id=\"btn_sb_gi_charge_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_location_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_location_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Location"
$html:=$html+"<a  id=\"btn_sb_gi_location_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_location_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_bien_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\" style=\"color:#c5c5c5\"></i></a>"
$html:=$html+"Bien"
$html:=$html+"<a  id=\"btn_sb_gi_bien_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_proprietaire_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_proprietaire_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Propriétaire"
$html:=$html+"<a  id=\"btn_sb_gi_proprietaire_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_facture_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_facture_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Facture"
$html:=$html+"<a  id=\"btn_sb_gi_facture_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_reglement_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_reglement_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Règlement"
$html:=$html+"<a  id=\"btn_sb_gi_reglement_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"<button type=\"button\" id=\"btn_sb_gi_basedoc_\" class=\"btn\">"
$html:=$html+"<a id=\"btn_sb_gi_basedoc_a\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-plus\"></i></a>"
$html:=$html+"Documents"
$html:=$html+"<a  id=\"btn_sb_gi_basedoc_l\" href=\"#\" class=\"btn_right\" ><i class=\"fa fa-list icon_right\"></i></a>"
$html:=$html+"</button>"

$html:=$html+"</div>"
$0:=$html