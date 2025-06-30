If (vb_MRferme=False:C215)
	vb_EtCivil:=False:C215
	If (F_HébergéEtatCivil(5))
		[DossierMedical:29]DM_EtatCivil:12:=va_IDT_Typ1
		[DossierMedical:29]DM_Nom:13:=va_IDT_Nom
		[DossierMedical:29]DM_Prénom:14:=va_IDT_Pré
		[DossierMedical:29]DM_Age:15:=ve_IDT_Age
		[DossierMedical:29]DM_DateNéLe:16:=vd_IDT_NéLe
		[DossierMedical:29]DM_Genre:18:=(x_IDTG_2=1)
		va_Identité:=[DossierMedical:29]DM_Nom:13+" "+[DossierMedical:29]DM_Prénom:14
	End if 
End if 