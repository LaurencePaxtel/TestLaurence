C_BOOLEAN:C305($vb_OK)
$vb_OK:=True:C214
If (<>vl_Trans_CentreRéf>0)
	If (<>vd_Trans_LastReportDate<Current date:C33)
		ALERT:C41("ATTENTION"+<>va_CR+"Veuillez vérifier que le report a été fait !"+<>va_CR+"Acceptation impossible.")
		$vb_OK:=False:C215
	End if 
End if 
If ($vb_OK)
	P_BAL_F(1)
End if 