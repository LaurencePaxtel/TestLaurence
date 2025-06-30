//Formule format : GI_EcranSaisie
If (Form event code:C388=Sur chargement:K2:1)
	
	If (vb_GIPsél)
		OBJECT SET VISIBLE:C603(*; "GIP_Suit@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "GIP_Sup@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "GIP_Val@"; False:C215)
		
		OBJECT SET VISIBLE:C603(*; "GIP_SThème@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "GIP_Metro@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "GIP_ARR@"; False:C215)
	Else 
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_Coordinateur))
		Else 
			OBJECT SET VISIBLE:C603(*; "GIP_Sup@"; False:C215)
		End if 
	End if 
	
	If (Is new record:C668([GIP:13]))
		[GIP:13]GI_ReferenceID:1:=Uut_Numerote(->[GIP:13])
		[GIP:13]GI_Rubrique:2:=<>Va_Rubrique
		[GIP:13]GI_Theme:3:=<>Va_Thème
		If (<>ta_SsTh>0)
			[GIP:13]GI_SousTheme:4:=va_LibSsTh
		End if 
		MultiSoc_Init_Structure(->[GIP:13])
	End if 
	SET WINDOW TITLE:C213(<>Va_Rubrique+" : "+<>Va_Thème)
End if 