Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Form:C1466.refCourant#Null:C1517)
			CONFIRM:C162("Êtes-vous certains de vouloir supprimer l'extra "+Form:C1466.refCourant.libelle+" ?"; "Oui"; "Non")
			
			If (OK=1)
				Form:C1466.detail.remove(Form:C1466.refPosition-1)
			End if 
			
		Else 
			ALERT:C41("Veuillez sélectionner une ligne")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 