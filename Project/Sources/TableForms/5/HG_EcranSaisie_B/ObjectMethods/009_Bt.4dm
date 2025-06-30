If (User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_Coordinateur) | User in group:C338(Current user:C182; <>Groupe_Régulateur))
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{3}; -><>ta_InPerm; ->[HeberGement:5]HG_Permanencier:9)
End if 