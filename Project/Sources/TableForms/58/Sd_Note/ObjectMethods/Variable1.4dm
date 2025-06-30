If (Form event code:C388=Sur clic:K2:4)
	If (Modified record:C314([SIAO_Divers:58]))
		Quit_SIAODivers
	Else 
		CANCEL:C270
	End if 
End if 