Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Current user:C182="apaxtel")
			OBJECT SET VISIBLE:C603(*; "Bouton5"; True:C214)
		End if 
		
		OBJECT SET ENABLED:C1123(*; "Bouton5"; (Current user:C182="apaxtel"))
	: (Form event code:C388=Sur clic:K2:4)
		CONFIRM:C162("Souhaitez-vous vraiment transformer les anciennes notes dans le nouveau format ?"; "Oui"; "Non")
		
		If (OK=1)
			outilsPaxtelRetroactif(2)
		End if 
		
End case 