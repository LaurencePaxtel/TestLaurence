If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Confirmez-vous la suppression de texte ?"))
		[DePart:1]DP_Texte:7:=""
	End if 
End if 