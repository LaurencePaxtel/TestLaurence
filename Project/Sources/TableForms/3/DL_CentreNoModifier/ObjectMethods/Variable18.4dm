If (Form event code:C388=Sur clic:K2:4)
	If (<>ve_T_CentreCode=ve_T_CentreCodeNew)
		ALERT:C41("Les codes sont identiques !")
		REJECT:C38
	End if 
End if 