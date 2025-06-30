<>vd_DtJour:=vd_DtJour
If (vd_DtJour>!00-00-00!)
	Rec_CL_DispoCalc(<>vd_DtJour)
Else 
	vl_CHCapaJ:=0
	vl_CHCapaN:=0
	
	vl_CHRepor:=0
	vl_CHReporJ:=0
	vl_CHReporN:=0
	
	vl_CHDispjJ:=0
	vl_CHDispjN:=0
	vl_CHDispTJ:=0
	vl_CHDispTN:=0
	
	vl_CHDistrJ:=0
	vl_CHDistrN:=0
	
	vl_CHRest:=0
	vl_CHRestJ:=0
	vl_CHRestN:=0
	vl_CHReste:=0
	vl_CHResteJ:=0
	vl_CHResteN:=0
	
	vl_CHWait:=0
	vl_CHWaitJ:=0
	vl_CHWaitN:=0
End if 