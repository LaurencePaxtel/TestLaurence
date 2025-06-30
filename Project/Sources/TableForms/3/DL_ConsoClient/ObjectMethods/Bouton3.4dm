If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Afficher les paramètres par défaut ?"))
		
		DébutInitConsoClient(2)
		r1:=Num:C11(<>vb_Conso115Clt=True:C214)
		r2:=Num:C11(<>vb_Conso115Clt=False:C215)
		
		
		<>vh_Conso115CltTicks:=<>vl_Conso115CltTicks/60
		
		
	End if 
End if 