//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 30/08/18, 04:42:58
// ----------------------------------------------------
// Méthode : Maint_Ref_Structure_All
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($i)

If (User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_ADMIN))
	CONFIRM:C162("Attention vous êtes entrain de lancer l'indexation"; "Oui"; "Non")
	
	If (OK=1)
		
		For ($i; 1; Get last table number:C254)
			
			If (Is table number valid:C999($i))
				Maint_Ref_Structure(Table:C252($i))
			End if 
			
		End for 
		
		ALERT:C41("Traitement effectué avec succès.")
	End if 
	
Else 
	ALERT:C41("Vous ne disposez pas des privilèges d'accès à la fonction d'indexation.")
End if 