If (<>vb_T_ModeCHRS & <>vb_T_Prestations)
	SET WINDOW TITLE:C213("Export des  prestations")
	If (F_uExportReportRec)
		OBJECT SET ENABLED:C1123(b_Val; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_Val; False:C215)
	End if 
Else 
	rExport_2:=0
	rExport_1:=1
End if 