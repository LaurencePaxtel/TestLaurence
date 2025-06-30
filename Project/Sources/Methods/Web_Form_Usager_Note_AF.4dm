//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 21/11/18, 01:56:25
// ----------------------------------------------------
// Méthode : Web_Form_Usager_Note_AF
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($html; $0)

C_LONGINT:C283($o)

$o:=0
$html:=""

$html:=$html+"<div id=\"iw_notes_af\">"

$html:=$html+"<div id=\"iw_notes_af_child\">"

$html:=$html+"<div class=\"portlet box grey iw_notes_sp\" >"
$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-commenting-o\"></i>Note AF</div>"
$html:=$html+"</div>"
$html:=$html+"<div class=\"portlet-body form\">"
$html:=$html+"<form enctype=\"multipart/form-data\" action=\"#\" method=\"post\" name=\"adminForm\" id=\"adminForm\" class=\"fdp_form\">"


$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"fdp_line tab-content\">"

$html:=$html+"<textarea id=\"hb_actionsf\" name=\"hb_actionsf\" placeholder=\"\">"+[HeBerge:4]HB_ActionsF:49+"</textarea>"

$html:=$html+"</form>"
$html:=$html+"</div>"
$html:=$html+"</div>"



$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html