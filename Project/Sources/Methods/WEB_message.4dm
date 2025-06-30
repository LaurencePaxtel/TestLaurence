//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 01:21:44
// ----------------------------------------------------
// Méthode : WEB_message
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($1)  //valeurs possibles : "info" ; "erreur"
C_TEXT:C284($2)

HTML_MESSAGE:="<div class=\"fdp_message\">"
HTML_MESSAGE:=HTML_MESSAGE+"<a class=\"close\" data-dismiss=\"alert\" href=\"#\">x</a>"
HTML_MESSAGE:=HTML_MESSAGE+$2
HTML_MESSAGE:=HTML_MESSAGE+"</div>"

WEB_UTL_page("app.html")