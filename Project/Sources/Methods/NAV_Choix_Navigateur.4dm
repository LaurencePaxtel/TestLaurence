//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 05/07/18, 17:20:51
// ----------------------------------------------------
// Méthode : NAV_Choix_Navigateur
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($menu; $ref_menu)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Contextual click:C713)
			$menu:=Create menu:C408
			
			APPEND MENU ITEM:C411($menu; "-")
			APPEND MENU ITEM:C411($menu; "Navigateur Principal")
			
			SET MENU ITEM PARAMETER:C1004($menu; -1; "DL_Départ")
			APPEND MENU ITEM:C411($menu; "Navigateur Principal - Ancien")
			
			SET MENU ITEM PARAMETER:C1004($menu; -1; "DL_Départ_old")
			$ref_menu:=Dynamic pop up menu:C1006($menu)
			
			CANCEL:C270
			
			NAV_Lancement_Navigateur($ref_menu)
		End if 
		
End case 