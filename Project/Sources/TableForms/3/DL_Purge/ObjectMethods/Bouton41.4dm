If (Form event code:C388=Sur clic:K2:4)
	FORM GOTO PAGE:C247(1)
	UNLOAD RECORD:C212([HeberGement:5])
	READ ONLY:C145([HeberGement:5])
	OBJECT SET TITLE:C194(b_EtatHB; "Lecture écriture")
End if 
