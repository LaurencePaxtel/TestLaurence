If (Form event code:C388=Sur chargement:K2:1)
	vb_MRferme:=False:C215
	If (Is new record:C668([DossierInfirmie:27]))
		MultiSoc_Init_Structure(->[DossierInfirmie:27])
		[DossierInfirmie:27]DI_Référence:1:=Uut_Numerote(->[DossierInfirmie:27])
		[DossierInfirmie:27]DI_Date:4:=Current date:C33(*)
		[DossierInfirmie:27]DI_Heure:5:=Current time:C178(*)
		[DossierInfirmie:27]DI_FicheNuméro:3:=Uut_NumeroteDossier("DI"; [DossierInfirmie:27]DI_Date:4)
		va_Identité:=""
		[DossierInfirmie:27]DI_Opérateur:8:=Current user:C182
		[DossierInfirmie:27]DI_HB_ID:10:=vl_RéfU_HBB
		[DossierInfirmie:27]DI_EtatCivil:12:=va_IDT_Typ1
		[DossierInfirmie:27]DI_Nom:13:=va_IDT_Nom
		[DossierInfirmie:27]DI_Prénom:14:=va_IDT_Pré
		[DossierInfirmie:27]DI_DateNéLe:16:=vd_IDT_NéLe
		
		[DossierInfirmie:27]DI_Age:15:=Uut_HébergéAgePlus(->[DossierInfirmie:27]DI_DateNéLe:16; ->[DossierInfirmie:27]DI_Date:4)
		[DossierInfirmie:27]DI_Genre:18:=(x_IDTG_1=0)
	End if 
	va_Identité:=[DossierInfirmie:27]DI_Nom:13+" "+[DossierInfirmie:27]DI_Prénom:14
	P_ChampAttribut(<>vlSTR_DI-<>vlSTR)
End if 