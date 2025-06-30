SET WINDOW TITLE:C213("Export du  report")

If (F_uExportReportRec)
	OBJECT SET ENABLED:C1123(b_Val; True:C214)
Else 
	OBJECT SET ENABLED:C1123(b_Val; False:C215)
End if 