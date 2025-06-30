If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Enregister les paramètres ?"))
		
		<>vb_ConsoRAuto:=(r1=1)
		<>vl_ConsoRAuto:=Num:C11(<>vb_ConsoRAuto=True:C214)
		
		
		<>vb_ConsoRServeurAuto:=False:C215
		DébutInitConsoR(1)
		
	End if 
End if 
