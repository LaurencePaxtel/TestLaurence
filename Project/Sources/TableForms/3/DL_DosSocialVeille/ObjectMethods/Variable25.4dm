//Script b_ModCléHG
If (Form event code:C388=Sur clic:K2:4)
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		StrAlerte(6; "'Modifier clé")
	Else 
		vb_Valider:=False:C215
		If ([DossierSocial:25]DS_HB_ID:10>0)
			vl_HGUU:=[DossierSocial:25]DS_HB_ID:10
			va_HGUU:=[DossierSocial:25]DS_Nom:12
			va_CléClé:=Uut_HébergéClé(->[DossierSocial:25]DS_Nom:12; ->[DossierSocial:25]DS_Prénom:16; ->[DossierSocial:25]DS_DateNéLe:18)
			If (F_UnDossierCléModifier)
			End if 
			P_DosSocialVeilleFind
			
		End if 
	End if 
End if 