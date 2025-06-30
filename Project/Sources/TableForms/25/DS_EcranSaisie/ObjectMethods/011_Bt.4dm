If (vb_MRferme=False:C215)
	vb_EtCivil:=False:C215
	If (F_HébergéEtatCivil(3))
		[DossierSocial:25]DS_EtatCivil:11:=va_IDT_Typ1
		[DossierSocial:25]DS_Nom:12:=va_IDT_Nom
		[DossierSocial:25]DS_Prénom:16:=va_IDT_Pré
		[DossierSocial:25]DS_Age:17:=ve_IDT_Age
		[DossierSocial:25]DS_DateNéLe:18:=vd_IDT_NéLe
		[DossierSocial:25]DS_Genre:20:=(x_IDTG_2=1)
		va_Identité:=[DossierSocial:25]DS_Nom:12+" "+[DossierSocial:25]DS_Prénom:16
	End if 
End if 