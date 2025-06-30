Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		Case of 
			: (Form:C1466.refSelection=Null:C1517)
				ALERT:C41("Merci de sélectionner d'abord un produit puis une ligne dans la liste des références produit (liste ci-dessus)")
			: (Form:C1466.refSelection.length=1)
				ALERT:C41("En cours de développement")
			Else 
				ALERT:C41("Merci de sélectionner uniquement une ligne dans la liste des références produit (liste ci-dessus)")
		End case 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 