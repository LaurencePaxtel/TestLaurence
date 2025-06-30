//Formule format : AS_EcranSaisie
If (Form event code:C388=Sur chargement:K2:1)
	If ([Assocs:14]AS_ReferenceID:1=0)
		[Assocs:14]AS_ReferenceID:1:=Uut_Numerote(->[Assocs:14])
	End if 
	MultiSoc_Init_Structure(->[Assocs:14])
	SET WINDOW TITLE:C213("Une association")
	If (vb_GIPsél)
		OBJECT SET VISIBLE:C603(*; "AS_Suit@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "AS_Sup@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "AS_Val@"; False:C215)
	Else 
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN))
		Else 
			OBJECT SET VISIBLE:C603(*; "AS_Sup@"; False:C215)
		End if 
	End if 
End if 
