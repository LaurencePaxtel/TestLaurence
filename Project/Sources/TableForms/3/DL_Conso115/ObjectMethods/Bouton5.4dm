If (Form event code:C388=Sur clic:K2:4)
	
	<>vb_Conso115Auto:=(r1=1)
	<>vl_Conso115Auto:=Num:C11(<>vb_Conso115Auto=True:C214)
	
	//◊vb_Conso115ServeurAuto:=(s1=1)
	
	If (Macintosh control down:C544) | (Windows Ctrl down:C562)
		DébutInitConso115(3)
	Else 
		DébutInitConso115(1)
	End if 
End if 