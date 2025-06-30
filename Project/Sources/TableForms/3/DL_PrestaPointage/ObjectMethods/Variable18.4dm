If (Form event code:C388=Sur clic:K2:4)
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (13/07/2021)
	If (Num:C11(Form:C1466.entree)=1)
		DébutInitPointage(1; True:C214)
	Else 
		DébutInitPointage(1)
	End if 
	
End if 