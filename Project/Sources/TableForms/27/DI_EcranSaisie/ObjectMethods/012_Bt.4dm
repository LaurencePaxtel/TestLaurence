If (vb_MRferme=False:C215)
	vb_EtCivil:=False:C215
	If (F_HébergéEtatCivil(4))
		[DossierInfirmie:27]DI_EtatCivil:12:=va_IDT_Typ1
		[DossierInfirmie:27]DI_Nom:13:=va_IDT_Nom
		[DossierInfirmie:27]DI_Prénom:14:=va_IDT_Pré
		[DossierInfirmie:27]DI_Age:15:=ve_IDT_Age
		[DossierInfirmie:27]DI_DateNéLe:16:=vd_IDT_NéLe
		[DossierInfirmie:27]DI_Genre:18:=(x_IDTG_2=1)
		va_Identité:=[DossierInfirmie:27]DI_Nom:13+" "+[DossierInfirmie:27]DI_Prénom:14
	End if 
End if 