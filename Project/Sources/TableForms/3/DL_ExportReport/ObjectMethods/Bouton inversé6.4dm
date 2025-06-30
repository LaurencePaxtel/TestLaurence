If (Form event code:C388=Sur clic:K2:4)
	Case of 
		: (Macintosh control down:C544 | Windows Ctrl down:C562)
			If (vd_ExportReportF>!00-00-00!)
				vd_ExportReportF:=vd_ExportReportF+1
			Else 
				vd_ExportReportF:=Current date:C33
			End if 
			
			
		: (Macintosh option down:C545 | Windows Alt down:C563)
			If (vd_ExportReportF>!00-00-00!)
				vd_ExportReportF:=vd_ExportReportF-1
			Else 
				vd_ExportReportF:=Current date:C33
			End if 
		Else 
			vd_ExportReportF:=Current date:C33
	End case 
	If (F_uExportReportRec)
		OBJECT SET ENABLED:C1123(b_Val; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_Val; False:C215)
	End if 
End if 

