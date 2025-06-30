//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Appel
//{
//{          Lundi 02 février 2004 à 14:27:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($param_t)  // [Optionnel]
C_LONGINT:C283($L_W)

$param_t:=Get selected menu item parameter:C1005

If ($param_t#"")
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
	// Ajout d'un menu pour accéder à la barre d'appel sans que l'utilisateur ait besoin de redémarrer le programme
	If (User in group:C338(Current user:C182; <>Groupe_Appel))
		Process_Go(-><>PR_Appel; "Go_Appel"; "Appel"; 0)
	End if 
	
Else 
	SET MENU BAR:C67(1)
	READ ONLY:C145(*)
	
	<>va_AppelMes:=""
	<>ta_Appels:=1
	
	// #20170605-1
	$L_W:=Open form window:C675([DiaLogues:3]; "DL_Appels"; Form fenêtre palette:K39:9; Centrée horizontalement:K39:1; En haut:K39:5; *)  // #20180423-2
	
	SET WINDOW TITLE:C213("Raccourcis Multi-fenêtres")
	DIALOG:C40([DiaLogues:3]; "DL_Appels")
	
	CLOSE WINDOW:C154($L_W)
	
	<>PR_Appel:=0
End if 