If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Afficher les paramètres par défaut ?"))
		
		DébutInitConso115(2)
		r1:=Num:C11(<>vb_Conso115Auto=True:C214)
		r2:=Num:C11(<>vb_Conso115Auto=False:C215)
		
		<>vh_Conso115Ticks:=<>vl_Conso115Ticks/60
		
	End if 
End if 