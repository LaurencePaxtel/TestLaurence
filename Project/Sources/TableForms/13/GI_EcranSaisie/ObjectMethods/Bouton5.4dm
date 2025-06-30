If (Form event code:C388=Sur clic:K2:4)
	FORM SET OUTPUT:C54([GIP:13]; "GI_PrtFiche")
	PRINT RECORD:C71([GIP:13])
	FORM SET OUTPUT:C54([GIP:13]; "GI_Liste")
End if 


