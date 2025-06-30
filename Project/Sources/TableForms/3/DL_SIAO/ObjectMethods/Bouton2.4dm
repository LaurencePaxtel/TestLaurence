If (Form event code:C388=Sur clic:K2:4)
	If (Macintosh option down:C545 | Windows Alt down:C563)
		[DiaLogues:3]DL_LibelléN:9:=""
	Else 
		If ([SIAO:50]Si_RéférenceID:1>0)
			[DiaLogues:3]DL_LibelléN:9:=[SIAO:50]Si_Demandeur:20
		End if 
	End if 
End if 