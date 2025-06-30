If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Supprimer le contenu du rapport ?"))
		[Rapport:35]RP_Note:9:=""
	End if 
End if 