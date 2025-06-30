If (Form event code:C388=Sur clic:K2:4)
	ALERT:C41("Utilisez le bouton ANNULER LE DERNIER REPORT")
	If (7=8)
		rJourNuit1:=1
		rJourNuit2:=0
		rReports:=0
		vd_ReportPurgeDt:=!00-00-00!
		vd_ReportPurgeDtLast:=!00-00-00!
		vl_ReportPurgeNb:=0
		FORM GOTO PAGE:C247(2)
		
		MESSAGES ON:C181
		vd_ReportPurgeDt:=!00-00-00!
		SCAN INDEX:C350([HeberGement:5]HG_Date:4; 2; <)
		FIRST RECORD:C50([HeberGement:5])
		vd_ReportPurgeDt:=[HeberGement:5]HG_Date:4
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ReportPurgeDt; *)
		QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Reporté:94="R@")
		MultiSoc_Filter(->[HeberGement:5])
		
		MESSAGES OFF:C175
	End if 
End if 
