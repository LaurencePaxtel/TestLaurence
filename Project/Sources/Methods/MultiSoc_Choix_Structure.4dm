//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 29/08/18, 21:14:39
// ----------------------------------------------------
// Méthode : MultiSoc_Choix_Structure
// Description
// 
//
// Paramètres
// ----------------------------------------------------
ARRAY TEXT:C222(Liste_uid_entreprise; 0)
ARRAY TEXT:C222(Liste_nom_entreprise; 0)
ARRAY TEXT:C222(Liste_initiales_entreprise; 0)

READ ONLY:C145([Structures:79])

If ((User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_ADMIN)))
	ALL RECORDS:C47([Structures:79])
	
	While (Not:C34(End selection:C36([Structures:79])))
		APPEND TO ARRAY:C911(Liste_uid_entreprise; [Structures:79]UID:1)
		APPEND TO ARRAY:C911(Liste_nom_entreprise; [Structures:79]STRC_Nom:4)
		APPEND TO ARRAY:C911(Liste_initiales_entreprise; [Structures:79]STRC_Initiales:2)
		
		NEXT RECORD:C51([Structures:79])
	End while 
	
Else 
	
	While (Not:C34(End selection:C36([Structure_User:80])))
		QUERY:C277([Structures:79]; [Structures:79]UID:1=[Structure_User:80]UID_Structure:1)
		
		APPEND TO ARRAY:C911(Liste_uid_entreprise; [Structures:79]UID:1)
		APPEND TO ARRAY:C911(Liste_nom_entreprise; [Structures:79]STRC_Nom:4)
		APPEND TO ARRAY:C911(Liste_initiales_entreprise; [Structures:79]STRC_Initiales:2)
		
		NEXT RECORD:C51([Structure_User:80])
	End while 
	
End if 

$ref_fenetre:=UTL_Fenetre(350; 150; 4; "login_choix_structure"; "UTL_Ferme_fenetre"; False:C215)

DIALOG:C40("login_choix_structure")
CLOSE WINDOW:C154($ref_fenetre)