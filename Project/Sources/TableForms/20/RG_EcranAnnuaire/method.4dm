
If (Form event code:C388=Sur chargement:K2:1)
	If (7=8)
		If (Is new record:C668([RenseiGnements:20]))
			MultiSoc_Init_Structure(->[RenseiGnements:20])
			<>ta_PrestRub:=3
			<>va_PrestThé:=""
			<>va_PrestNom:=""
			[RenseiGnements:20]RG_Rubrique:6:=<>ta_PrestRub{<>ta_PrestRub}
			<>ta_PrestRub{0}:=<>ta_PrestRub{<>ta_PrestRub}
			
			ARRAY TEXT:C222(<>ta_PrestThé; 0)
			ARRAY TEXT:C222(<>ta_PrestNom; 0)
			ARRAY TEXT:C222(ta_PrestNom; 0)
			<>va_PrestNom:=""
			<>va_PrestBis:=""
			[RenseiGnements:20]RG_Nom:8:=""
			TableRG_Rub(<>ta_PrestRub)
			[RenseiGnements:20]RG_Thème:7:=<>ta_PrestThé{<>ta_PrestThé}
		End if 
	End if 
End if 
