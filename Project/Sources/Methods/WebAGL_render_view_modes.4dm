//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 00:06:17
// ----------------------------------------------------
// Méthode : WebAGL_render_view_modes
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)

C_TEXT:C284(REDIRECT_LINK; HTML_NB_MODULE; MODAL_DELETE_EDIT; CONFIRM_MESSAGE)
C_BOOLEAN:C305(STOP_VALIDATION)

If (Count parameters:C259>=1)
	File_ptr:=$1
End if 

WebAGL_render_view("form"; "app")