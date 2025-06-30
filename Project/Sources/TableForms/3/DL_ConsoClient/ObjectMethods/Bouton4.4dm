If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Enregister les paramètres ?"))
		
		<>vb_Conso115Clt:=(r1=1)
		<>vl_Conso115Clt:=Num:C11(<>vb_Conso115Clt=True:C214)
		
		
		<>vb_Conso115ServeurCltAuto:=(s1=1)
		
		If (Macintosh control down:C544) | (Windows Ctrl down:C562)
			DébutInitConsoClient(3)
		Else 
			DébutInitConsoClient(1)
		End if 
	End if 
End if 
