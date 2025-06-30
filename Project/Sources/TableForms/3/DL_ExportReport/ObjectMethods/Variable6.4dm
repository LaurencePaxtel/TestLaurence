If (Form event code:C388=Sur données modifiées:K2:15)
	If (F_uExportReportRec)
		OBJECT SET ENABLED:C1123(b_Val; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_Val; False:C215)
	End if 
End if 

