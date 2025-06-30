If (Records in selection:C76([APpels:19])>0)
	vl_HNbAA:=Records in selection:C76([APpels:19])
	va_Lutilisa:=<>va_User
	ORDER BY:C49([APpels:19]; [APpels:19]AP_Date:2; >; *)
	ORDER BY:C49([APpels:19]; [APpels:19]AP_Heure:3; >)
	FIRST RECORD:C50([APpels:19])
	
	FORM SET OUTPUT:C54([APpels:19]; "AP_ListePrint")
	_O_PAGE SETUP:C299([APpels:19]; "AP_ListePrint")
	PRINT SETTINGS:C106
	If (OK=1)
		PRINT SELECTION:C60([APpels:19]; *)
	End if 
	ORDER BY:C49([APpels:19]; [APpels:19]AP_Date:2; <; *)
	ORDER BY:C49([APpels:19]; [APpels:19]AP_Heure:3; <)
	FIRST RECORD:C50([APpels:19])
End if 