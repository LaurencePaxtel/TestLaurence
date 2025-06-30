If (Form event code:C388=Sur clic:K2:4)
	If (User in group:C338(Current user:C182; <>Groupe_Editeur))
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		QR REPORT:C197([SIAO:50]; Char:C90(1))
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	Else 
		StrAlerte(6; "Imprimer liste")
	End if 
End if 
