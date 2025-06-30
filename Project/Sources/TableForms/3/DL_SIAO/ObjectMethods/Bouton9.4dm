If (Form event code:C388=Sur clic:K2:4)
	_O_PAGE SETUP:C299([SIAO:50]; "Si_ListeIncluePrint")
	PRINT SETTINGS:C106
	If (OK=1)
		vL_NbFiches:=Records in selection:C76([SIAO:50])
		FORM SET OUTPUT:C54([SIAO:50]; "Si_ListeIncluePrint")
		PRINT SELECTION:C60([SIAO:50]; *)
	End if 
End if 
