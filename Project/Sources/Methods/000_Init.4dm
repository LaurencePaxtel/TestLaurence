//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 00:35:29
// ----------------------------------------------------
// Méthode : 000_Init
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var Nom_structure; FIX_PARAM_ACTION; w_action; HTML_LINK_NAV; smtp_server; smtp_username; smtp_password; admin_email; language; website_domain; \
HTML_INCLUDE_PAGE_TERMS; HTML_INCLUDE_PAGE_PRIVACY : Text
var w_userUID : Integer
var NO_STYLE; USR_IS_Manager : Boolean

ARRAY TEXT:C222(tb_admins_emails; 0)

w_userUID:=-1

smtp_server:=""
smtp_username:=""
smtp_password:=""

admin_email:=""
Nom_structure:=""

w_action:=""

FIX_PARAM_ACTION:=""
HTML_LINK_NAV:="#"

NO_STYLE:=False:C215

APPEND TO ARRAY:C911(tb_admins_emails; admin_email)