If (Form event code:C388=Sur clic:K2:4)
	If (vL_NbFiches>0)
		If (i_Confirmer("Voulez-vous envoyer par mail la liste des personnes en fin d'hébergement ?"))
			
			If (F_MailReport_Corps(2))
				
			End if 
		End if 
	End if 
End if 