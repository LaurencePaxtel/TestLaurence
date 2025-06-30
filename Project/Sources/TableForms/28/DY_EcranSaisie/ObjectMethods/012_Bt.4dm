If (vb_MRferme=False:C215)
	vb_EtCivil:=False:C215
	If (F_HébergéEtatCivil(6))
		[DossierPsycho:28]DY_EtatCivil:12:=va_IDT_Typ1
		[DossierPsycho:28]DY_Nom:13:=va_IDT_Nom
		[DossierPsycho:28]DY_Prénom:14:=va_IDT_Pré
		[DossierPsycho:28]DY_Age:15:=ve_IDT_Age
		[DossierPsycho:28]DY_DateNéLe:16:=vd_IDT_NéLe
		[DossierPsycho:28]DY_Genre:18:=(x_IDTG_2=1)
		va_Identité:=[DossierPsycho:28]DY_Nom:13+" "+[DossierPsycho:28]DY_Prénom:14
	End if 
End if 