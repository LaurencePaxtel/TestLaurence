If (Form event code:C388=Sur clic:K2:4)
	
	If ([HeberGement:5]HG_ER_Remplaçant:130)
		[HeberGement:5]HG_AutreSolutio:88:=<>va_HG_AutreSolRemp
		P_HébergementExcuser(True:C214; 1)
	Else 
		[HeberGement:5]HG_AutreSolutio:88:=Old:C35([HeberGement:5]HG_AutreSolutio:88)
		[HeberGement:5]HG_AutreSolSuite:123:=""
		P_HébergementExcuser(True:C214; 2)
	End if 
End if 
