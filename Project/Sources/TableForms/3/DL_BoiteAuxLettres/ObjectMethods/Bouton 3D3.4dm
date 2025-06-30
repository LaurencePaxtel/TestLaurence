If (7=8)  //01/08/2012
	If (<>vd_Trans_LastReportDate<vd_DocuDateFiche)
		ALERT:C41("ATTENTION"+<>va_CR+"Veuillez vérifier que le report a été fait !"+<>va_CR+"Acceptation impossible.")
	Else 
		P_BAL_D(1)
	End if 
End if 

P_BAL_D(1)