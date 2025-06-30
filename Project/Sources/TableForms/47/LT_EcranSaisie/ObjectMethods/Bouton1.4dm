If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Report des valeurs par défaut ?"))
		If ([LesTranches:47]LT_Catégorie:1>"")
			P_LesTranchesParDefaut([LesTranches:47]LT_Catégorie:1)
			OBJECT SET VISIBLE:C603(*; "TR@"; True:C214)
			P_LesTranchesAffichées([LesTranches:47]LT_Nombre:2)
		End if 
	End if 
End if 