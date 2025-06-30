If (Form event code:C388=Sur chargement:K2:1)
	
	If (vb_GIPsél)
		OBJECT SET VISIBLE:C603(*; "AS_Add@"; False:C215)
	Else 
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_Coordinateur) | User in group:C338(Current user:C182; <>Groupe_Régulateur))
		Else 
			OBJECT SET VISIBLE:C603(*; "AS_Add@"; False:C215)
		End if 
		OBJECT SET VISIBLE:C603(*; "AS_Sel@"; False:C215)
	End if 
	
	SET WINDOW TITLE:C213("Liste des associations : "+String:C10(Records in selection:C76([Assocs:14])))
End if 