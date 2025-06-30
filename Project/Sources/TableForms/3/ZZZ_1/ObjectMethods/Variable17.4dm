//Script CL_ListePrint : b_Imp
_O_PAGE SETUP:C299([CentresLits:16]; "CL_CtrDisponibilité_ListePlus")
PRINT SETTINGS:C106
If (OK=1)
	FORM SET OUTPUT:C54([CentresLits:16]; "CL_CtrDisponibilité_ListePlus")
	PRINT SELECTION:C60([CentresLits:16]; *)
End if 