//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 00:07:21
// ----------------------------------------------------
// Méthode : WebAGL_render_view
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TEXT:C284($layout; $SOUS_FOLDER)

C_TEXT:C284(HTML_NAV_PATH; BTN_PRINT_MENU; BTN_LISTE; SELECT; RECH_HTML)
C_BOOLEAN:C305(LOCK; BTN_MAIL)

If (Undefined:C82($2))
	$layout:=HTML_LAYOUT_NAME
Else 
	$layout:=$2
End if 

If (Count parameters:C259=3)
	$SOUS_FOLDER:=$3+"/"
	HTML_NAV_PATH:=HTML_LAYOUT_PATH+$SOUS_FOLDER
End if 

WEB_MAIN_MENU_TOP

If (FIX_PARAM_BTNS="Right")
	FIX_PARAM_BTNS:=FIX_PARAM_BTNSD
End if 

If ($layout="")
	WEB SEND FILE:C619(HTML_LAYOUT_PATH+"views/"+$1+".html")
Else 
	HTML_CONTENT:="<!--4DINCLUDE views/"+$1+".html -->"
	WEB SEND FILE:C619(HTML_LAYOUT_PATH+$SOUS_FOLDER+$layout+".html")
End if 