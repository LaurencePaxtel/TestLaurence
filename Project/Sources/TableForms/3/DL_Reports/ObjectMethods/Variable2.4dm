//Script b_VoirPrt
If (Form event code:C388=Sur clic:K2:4)
	_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtReports")
	PRINT SETTINGS:C106
	If (OK=1)
		vL_NbFiches:=Records in selection:C76([HeberGement:5])
		FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtReports")
		PRINT SELECTION:C60([HeberGement:5]; *)
	End if 
End if 