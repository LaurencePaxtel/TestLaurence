If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Enregister les paramètres ?"))
		
		<>vb_ConsoTransfert:=(r1=1)
		<>vl_ConsoTransfert:=Num:C11(<>vb_ConsoTransfert=True:C214)
		
		
		<>vb_ConsoTransfertServeur:=False:C215
		DebutInitConsoTranfert(1)
	End if 
End if 
