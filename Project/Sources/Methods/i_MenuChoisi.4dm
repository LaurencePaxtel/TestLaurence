//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : i_MenuChoisi
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

ARRAY TEXT:C222($menuTitre_at; 0)
ARRAY TEXT:C222($menuRef_at; 0)

<>vl_Menu:=Int:C8(Menu selected:C152/65536)
<>vl_Ligne:=Mod:C98(Menu selected:C152; 65536)

GET MENU ITEMS:C977(Get menu bar reference:C979(Frontmost process:C327); $menuTitre_at; $menuRef_at)

Case of 
	: (<>vl_Menu=1)
		
		Case of 
			: (<>vl_Ligne=1)
				
				If (Frontmost process:C327(*)=<>PR_Genéral)
					Quit_Général
				Else 
					ALERT:C41("Pour quitter l'application"+<>va_CR+"Vous devez revenir au niveau général !")
				End if 
				
			: (<>vl_Ligne=2)
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
				// Ajout d'un menu pour accéder à la barre d'appel sans que l'utilisateur ait besoin de redémarrer le programme
				If (User in group:C338(Current user:C182; <>Groupe_Appel))
					Process_Go(-><>PR_Appel; "Go_Appel"; "Appel"; 0)
				End if 
				
		End case 
		
	: (<>vl_Menu=2)
	: (<>vl_Menu=3)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (17/11/2021)
		Case of 
			: (<>vl_Ligne=1) & (Find in array:C230($menuTitre_at; "Imprimer")=3)
				READ WRITE:C146([DOCWPRO:121])
				
				outilsBibliothequeNumerique
		End case 
		
End case 