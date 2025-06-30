If (Form event code:C388=Sur clic:K2:4)
	vb_ReportAuto:=(r1=1)
	vl_ReportAuto:=Num:C11(vb_ReportAuto=True:C214)
	
	
	ve_ReportAutoDi:=(1*Di1)
	ve_ReportAutoLu:=(2*Lu1)
	ve_ReportAutoMa:=(3*Ma1)
	ve_ReportAutoMe:=(4*We1)
	ve_ReportAutoJe:=(5*Je1)
	ve_ReportAutoVe:=(6*Ve1)
	ve_ReportAutoSa:=(7*Sa1)
	
	If (Macintosh control down:C544) | (Windows Ctrl down:C562)
		DébutInitReportAuto(3)
	Else 
		DébutInitReportAuto(1)
	End if 
	
End if 