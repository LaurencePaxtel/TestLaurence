If (vd_ExportReportF>!00-00-00!)
	vd_ExportReportF:=vd_ExportReportF-1
Else 
	vd_ExportReportF:=Current date:C33
End if 
If (F_uExportReportRec)
	OBJECT SET ENABLED:C1123(b_Val; True:C214)
Else 
	OBJECT SET ENABLED:C1123(b_Val; False:C215)
End if 