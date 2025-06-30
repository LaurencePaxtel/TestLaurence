If (Form event code:C388=Sur clic:K2:4)
	FORM GOTO PAGE:C247(2)
	rJourNuit1:=1
	rJourNuit2:=1
	rReports:=1
	vd_ReportPurgeDt:=!00-00-00!
	vd_ReportPurgeDtLast:=!00-00-00!
	P_PurgesReport(0)
	UNLOAD RECORD:C212([HeberGement:5])
	READ ONLY:C145([HeberGement:5])
	OBJECT SET TITLE:C194(b_EtatHB; "Lecture écriture")
End if 
