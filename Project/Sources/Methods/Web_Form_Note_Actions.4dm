//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 21/11/18, 01:33:07
// ----------------------------------------------------
// Méthode : Web_Form_Note_Actions
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($html; $0)


C_LONGINT:C283($o)

$o:=0
$html:=""

$html:=$html+"<div id=\"iw_notes_actions\">"

$html:=$html+"<div id=\"iw_notes_actions_child\">"

$html:=$html+"<div class=\"portlet box grey iw_notes_sp\" >"
$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-commenting-o\"></i>Note Actions</div>"
$html:=$html+"</div>"
$html:=$html+"<div class=\"portlet-body form\">"
$html:=$html+"<form enctype=\"multipart/form-data\" action=\"#\" method=\"post\" name=\"adminForm\" id=\"adminForm\" class=\"fdp_form\">"


$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"fdp_line tab-content\">"


$html:=$html+"<textarea id=\"hg_actions\" name=\"hg_actions\" placeholder=\"\">"+[HeBerge:4]HG_Actions:40+"</textarea>"

$html:=$html+"</form>"
$html:=$html+"</div>"
$html:=$html+"</div>"



$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html