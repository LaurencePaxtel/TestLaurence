//%attributes = {}
C_BOOLEAN:C305($0)
C_BOOLEAN:C305($vb_OK)

vl_ExportJours:=(vd_ExportReportF-vd_ExportReportD)+1
$vb_OK:=(vd_ExportReportD>!00-00-00!)
$vb_OK:=$vb_OK & (vd_ExportReportD<=vd_ExportReportF)
If ($vb_OK)
	If (7=8)
		If (vd_ExportReportD=vd_ExportReportF)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ExportReportD; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_ExportReportD; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_ExportReportF; *)
		End if 
		
		If (va_ExportReportPlateforme>"")
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Plateforme:139=va_ExportReportPlateforme; *)
		End if 
		
		If (vb_ExportReport115)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=0; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=999999; *)
		End if 
		If (rExport_1=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Trans_DDASS:141=True:C214; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92>1)
		Else 
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214)
		End if 
	Else 
		If (vd_ExportReportD=vd_ExportReportF)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ExportReportD; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_ExportReportD; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_ExportReportF; *)
		End if 
		If (va_ExportReportPlateforme>"")
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Plateforme:139=va_ExportReportPlateforme; *)
		End if 
		If (vb_ExportReport115)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=0; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=999999; *)
		End if 
		
		Case of 
			: (rExport_1=1)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Trans_DDASS:141=True:C214; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92>1)
				
			: (rExport_2=1)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214)
				
			: (rExport_3=1)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Trans_DDASS:141=True:C214; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1)
		End case 
	End if 
	
	MultiSoc_Filter(->[HeberGement:5])
	vl_ExportReport:=Records in selection:C76([HeberGement:5])
Else 
	ALERT:C41("Vérifiez la cohérence des dates !")
End if 
$0:=(vl_ExportReport>0)


