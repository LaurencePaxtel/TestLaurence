Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CONFIRM:C162("Voulez-vous imprimer le document ?"; "Oui"; "Non")
		
		If (OK=1)
			outilsWProImprimer(True:C214; "simple"; ""; [DOCWPRO:121]fichier:4)
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 