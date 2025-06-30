If (Form event code:C388=Sur chargement:K2:1)
	r1:=Num:C11(vb_ReportAuto=True:C214)
	r2:=Num:C11(vb_ReportAuto=False:C215)
	
	Di1:=Num:C11(ve_ReportAutoDi>0)
	Di2:=Num:C11(ve_ReportAutoDi=0)
	
	Lu1:=Num:C11(ve_ReportAutoLu>0)
	Lu2:=Num:C11(ve_ReportAutoLu=0)
	
	Ma1:=Num:C11(ve_ReportAutoMa>0)
	Ma2:=Num:C11(ve_ReportAutoMa=0)
	
	We1:=Num:C11(ve_ReportAutoMe>0)
	We2:=Num:C11(ve_ReportAutoMe=0)
	
	Je1:=Num:C11(ve_ReportAutoJe>0)
	Je2:=Num:C11(ve_ReportAutoJe=0)
	
	Ve1:=Num:C11(ve_ReportAutoVe>0)
	Ve2:=Num:C11(ve_ReportAutoVe=0)
	
	Sa1:=Num:C11(ve_ReportAutoSa>0)
	Sa2:=Num:C11(ve_ReportAutoSa=0)
	
	
	vh_ReportTicks:=vl_ReportAutoTicks/60
	
End if 