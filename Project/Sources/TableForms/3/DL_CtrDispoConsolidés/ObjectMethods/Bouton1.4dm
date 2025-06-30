//Script CL_ListePrint : b_Imp
_O_PAGE SETUP:C299([CentresLits:16]; "CL_CtrOccupation_Liste")
PRINT SETTINGS:C106
If (OK=1)
	vd_Date1:=[DiaLogues:3]DL_Date:2
	ORDER BY:C49([CentresLits:16]; [CentresLits:16]CL_Niveau:17; >; *)
	ORDER BY:C49([CentresLits:16]; [LesCentres:9]LC_Nom:4; >)
	FIRST RECORD:C50([CentresLits:16])
	VEntierLong1:=100
	BREAK LEVEL:C302(2)
	ACCUMULATE:C303([CentresLits:16]CL_Capacité:4)
	FORM SET OUTPUT:C54([CentresLits:16]; "CL_CtrOccupation_Liste")
	PRINT SELECTION:C60([CentresLits:16]; *)
End if 