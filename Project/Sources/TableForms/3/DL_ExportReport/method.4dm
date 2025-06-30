If (Form event code:C388=Sur chargement:K2:1)
	rExport_1:=1  //Export report
	rExport_2:=0  //Prestations
	rExport_3:=0  //1ère
	
	If (F_uExportReportRec)
		OBJECT SET ENABLED:C1123(b_Val; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_Val; False:C215)
	End if 
End if 


