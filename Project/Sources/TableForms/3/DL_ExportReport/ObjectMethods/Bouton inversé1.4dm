If (vd_ExportReportD>!00-00-00!)
	vd_ExportReportD:=vd_ExportReportD-1
Else 
	vd_ExportReportD:=Current date:C33
End if 
If (F_uExportReportRec)
	OBJECT SET ENABLED:C1123(b_Val; True:C214)
Else 
	OBJECT SET ENABLED:C1123(b_Val; False:C215)
End if 