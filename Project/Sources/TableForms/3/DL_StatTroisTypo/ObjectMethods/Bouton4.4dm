//Script b_Imp 
If (Form event code:C388=Sur clic:K2:4)
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		StrAlerte(6; "Imprimer liste")
	Else 
		If (User in group:C338(Current user:C182; <>Groupe_Editeur))
			SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
			FIRST RECORD:C50([HeberGement:5])
			QR REPORT:C197([HeberGement:5]; Char:C90(1))
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		Else 
			StrAlerte(6; "Imprimer liste")
		End if 
	End if 
End if 
