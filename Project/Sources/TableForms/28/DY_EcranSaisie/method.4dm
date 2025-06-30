If (Form event code:C388=Sur chargement:K2:1)
	vb_MRferme:=False:C215
	If (Is new record:C668([DossierPsycho:28]))
		[DossierPsycho:28]DY_Référence:1:=Uut_Numerote(->[DossierPsycho:28])
		[DossierPsycho:28]DY_Date:4:=Current date:C33(*)
		[DossierPsycho:28]DY_Heure:5:=Current time:C178(*)
		[DossierPsycho:28]DY_FicheNuméro:3:=Uut_NumeroteDossier("DY"; [DossierPsycho:28]DY_Date:4)
		va_Identité:=""
		[DossierPsycho:28]DY_Opérateur:8:=Current user:C182
		[DossierPsycho:28]DY_HB_ID:10:=vl_RéfU_HBB
		[DossierPsycho:28]DY_EtatCivil:12:=va_IDT_Typ1
		[DossierPsycho:28]DY_Nom:13:=va_IDT_Nom
		[DossierPsycho:28]DY_Prénom:14:=va_IDT_Pré
		[DossierPsycho:28]DY_DateNéLe:16:=vd_IDT_NéLe
		[DossierPsycho:28]DY_Age:15:=Uut_HébergéAgePlus(->[DossierPsycho:28]DY_DateNéLe:16; ->[DossierPsycho:28]DY_Date:4)
		[DossierPsycho:28]DY_Genre:18:=(x_IDTG_1=0)
	End if 
	va_Identité:=[DossierPsycho:28]DY_Nom:13+" "+[DossierPsycho:28]DY_Prénom:14
	P_ChampAttribut(<>vlSTR_DY-<>vlSTR)
End if 
