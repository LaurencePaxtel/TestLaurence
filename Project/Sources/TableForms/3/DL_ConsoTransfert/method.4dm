If (Form event code:C388=Sur chargement:K2:1)
	r1:=Num:C11(<>vb_ConsoTransfert=True:C214)
	r2:=Num:C11(<>vb_ConsoTransfert=False:C215)
	
	<>vh_ConsoTransfertTicks:=<>vl_ConsoTransfertTicks/60
	vt_ConsoTransfertOrigine:=<>vt_T_CheminRép
	vt_ConsoTransfertDestination:=<>vt_T_CheminSO_CheminRepDistant
	
	
End if 