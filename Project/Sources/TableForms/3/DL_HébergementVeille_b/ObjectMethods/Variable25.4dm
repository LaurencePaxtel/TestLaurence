//Script b_ModCléHG
If (Form event code:C388=Sur clic:K2:4)
	
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		StrAlerte(6; "'Modifier clé")
	Else 
		vb_Valider:=False:C215
		
		LOAD RECORD:C52([HeberGement:5])  // migration v15
		If ([HeberGement:5]HG_ReferenceID:1>0)
			vl_HGUU:=[HeberGement:5]HG_HB_ID:19
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_HGUU)
			If (Records in selection:C76([HeBerge:4])=1)
				va_HGUU:=[HeBerge:4]HB_Nom:3
				va_CléClé:=[HeBerge:4]HB_Clé:2
			Else 
				va_HGUU:=[HeberGement:5]HG_Nom:21
				va_CléClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
			End if 
			If (F_UnDossierCléModifier)
			End if 
			P_HébergementVeilleFind
		End if 
	End if 
End if 