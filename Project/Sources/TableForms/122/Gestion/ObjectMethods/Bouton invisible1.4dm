Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Form:C1466.elementSelection.length=1)
			ALERT:C41("En cours de développement")
		Else 
			ALERT:C41("Merci de sélectionner uniquement une ligne dans la liste des produits (liste ci-dessus)")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 