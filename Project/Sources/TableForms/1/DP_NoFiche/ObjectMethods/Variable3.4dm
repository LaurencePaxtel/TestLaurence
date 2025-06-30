If (Form event code:C388=Sur données modifiées:K2:15)
	If ([ReferenceUnique:2]RU_Fichier:2>"")
		If (vl_Numéro<vl_NombrePG)
			vl_Numéro:=vl_NombrePG
		End if 
	End if 
End if 