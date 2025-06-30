Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If ([Structures:79]Ref_Structure:3#"") & ([Structures:79]Ref_Structure:3#"TMP") & ([Structures:79]STRC_Indexation:7=False:C215)
			OBJECT SET ENABLED:C1123(Self:C308->; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Self:C308->=1)
			STRC_Var_Indexation:=True:C214
		Else 
			STRC_Var_Indexation:=False:C215
		End if 
		
End case 