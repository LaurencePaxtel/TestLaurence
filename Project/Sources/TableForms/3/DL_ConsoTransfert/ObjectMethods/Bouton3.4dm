If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Afficher les paramètres enregistrés ?"))
		DebutInitConsoTranfert(4)
		r1:=Num:C11(<>vb_ConsoTransfert=True:C214)
		r2:=Num:C11(<>vb_ConsoTransfert=False:C215)
		
		<>vh_ConsoTransfertTicks:=<>vl_ConsoTransfertTicks/60
		
		
	End if 
End if 