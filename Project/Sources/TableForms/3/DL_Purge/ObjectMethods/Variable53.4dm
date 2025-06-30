//Script b_VoirPrtL
If (Form event code:C388=Sur clic:K2:4)
	If (Macintosh control down:C544) | (Windows Ctrl down:C562)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		FIRST RECORD:C50([HeberGement:5])
		QR REPORT:C197([HeberGement:5]; Char:C90(1))
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	Else 
		_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtVeille")
		PRINT SETTINGS:C106
		If (OK=1)
			FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtVeille")
			PRINT SELECTION:C60([HeberGement:5]; *)
		End if 
		FORM SET OUTPUT:C54([HeberGement:5]; "HG_ListeInclueReport")
	End if 
End if 
