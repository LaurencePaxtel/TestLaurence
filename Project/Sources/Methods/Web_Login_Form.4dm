//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 01:11:29
// ----------------------------------------------------
// Méthode : Web_Login_Form
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($action)

C_TEXT:C284(HTML_CONTENT; BTN_LISTE; w_mess; HTML_NAME_MODULE; $action)
C_TEXT:C284(LANG_TXT_PASSWORD_RESET)

$action:=WEB_UTL_getVal("action")

HTML_HOME:="Connexion"

BTN_LISTE:="<div class=\"fdp_boutons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"submit_login\" type=\"submit\" class=\"fdp_Button  fdp_btn_top\" onclick=\"document.getElementById('method').value='POST';document.getElementById('login').submit(); return false;\"><i class=\"fa fa-sign-in\"></i> Connexion</button>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

HTML_CONTENT:=""

HTML_CONTENT:=HTML_CONTENT+"<div class=\"span12\">"
HTML_CONTENT:=HTML_CONTENT+"<div class=\"fdp-border fdp-login-form\">"

If (w_mess#"")
	HTML_CONTENT:=HTML_CONTENT+"<div id=\"mess\" class=\"fdp_message\" style=\"margin: 10px 0px 15px 2px;\">"
	HTML_CONTENT:=HTML_CONTENT+"<a class=\"close\" data-dismiss=\"alert\" href=\"#\">x</a>"
	
	If (w_mess#"")
		HTML_CONTENT:=HTML_CONTENT+"<div class=\"notification info\">"
		HTML_CONTENT:=HTML_CONTENT+w_mess
		HTML_CONTENT:=HTML_CONTENT+"</div>"
	End if 
	
	HTML_CONTENT:=HTML_CONTENT+"</div>"
End if 

HTML_CONTENT:=HTML_CONTENT+"<form id=\"login\" method=\"POST\" action=\"/login\" onclick=\"return false;\">"
HTML_CONTENT:=HTML_CONTENT+"<fieldset style=\"margin-bottom:5px !important;\">"
HTML_CONTENT:=HTML_CONTENT+"<div class=\"control-group \">"
HTML_CONTENT:=HTML_CONTENT+"<div class=\"controls\">"
HTML_CONTENT:=HTML_CONTENT+"<input Type=\"text\" id=\"identifier\" name=\"identifier\"  class=\" search fdp_placeholder fdp_row_start \" placeholder=\"Utilisateur\" >"
HTML_CONTENT:=HTML_CONTENT+"</div>"
HTML_CONTENT:=HTML_CONTENT+"</div>"
HTML_CONTENT:=HTML_CONTENT+"<div class=\"control-group \">"
HTML_CONTENT:=HTML_CONTENT+"<div class=\"controls\">"
HTML_CONTENT:=HTML_CONTENT+"<input Type=\"password\" id=\"password\" name=\"password\"  class=\" search fdp_placeholder fdp_row_start \" placeholder=\"Mot de passe\" >"
HTML_CONTENT:=HTML_CONTENT+"</div>"
HTML_CONTENT:=HTML_CONTENT+"</div>"

HTML_CONTENT:=HTML_CONTENT+BTN_LISTE
HTML_CONTENT:=HTML_CONTENT+"<input type=\"hidden\" id=\"redirect_action\" name=\"redirect_action\" value=\""+$action+"\" class=\"\" >"

HTML_CONTENT:=HTML_CONTENT+"<input type=\"hidden\" id=\"fbmail\" name=\"fbmail\" value=\"\" class=\"\" >"
HTML_CONTENT:=HTML_CONTENT+"<input type=\"hidden\" id=\"fbid\" name=\"fbid\" value=\"\" class=\"\" >"
HTML_CONTENT:=HTML_CONTENT+"<input type=\"hidden\" id=\"fb_first_name\" name=\"fb_first_name\" value=\"\" class=\"\" >"
HTML_CONTENT:=HTML_CONTENT+"<input type=\"hidden\" id=\"fb_last_name\" name=\"fb_last_name\" value=\"\" class=\"\" >"
HTML_CONTENT:=HTML_CONTENT+"<input type=\"hidden\" id=\"fb_gender\" name=\"fb_gender\" value=\"\" class=\"\" >"
HTML_CONTENT:=HTML_CONTENT+"<input type=\"hidden\" id=\"fbtoken\" name=\"fbtoken\" value=\"\" class=\"\" >"

HTML_CONTENT:=HTML_CONTENT+"<div id=\"fb-root\"></div>"

HTML_CONTENT:=HTML_CONTENT+"<div id=\"status\">"
HTML_CONTENT:=HTML_CONTENT+"</div>"

HTML_CONTENT:=HTML_CONTENT+"</fieldset>"
HTML_CONTENT:=HTML_CONTENT+"</form>"

HTML_CONTENT:=HTML_CONTENT+"<input data-val=\"GET\" type=\"hidden\" id=\"method\" name=\"method\" value=\"GET\" class=\"\" >"

HTML_CONTENT:=HTML_CONTENT+"</div>"
HTML_CONTENT:=HTML_CONTENT+"</div>"

BTN_LISTE:=""

WEB SEND FILE:C619("pages/login.html")