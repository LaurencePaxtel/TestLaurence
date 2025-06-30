If (Form event code:C388=Sur chargement:K2:1)
	vb_MRferme:=False:C215
	If (Is new record:C668([DossierMedical:29]))
		[DossierMedical:29]DM_Référence:1:=Uut_Numerote(->[DossierMedical:29])
		[DossierMedical:29]DM_Date:4:=Current date:C33(*)
		[DossierMedical:29]DM_Heure:5:=Current time:C178(*)
		[DossierMedical:29]DM_FicheNuméro:3:=Uut_NumeroteDossier("DM"; [DossierMedical:29]DM_Date:4)
		va_Identité:=""
		[DossierMedical:29]DM_Opérateur:8:=Current user:C182
		[DossierMedical:29]DM_HB_ID:10:=vl_RéfU_HBB
		[DossierMedical:29]DM_EtatCivil:12:=va_IDT_Typ1
		[DossierMedical:29]DM_Nom:13:=va_IDT_Nom
		[DossierMedical:29]DM_Prénom:14:=va_IDT_Pré
		[DossierMedical:29]DM_DateNéLe:16:=vd_IDT_NéLe
		
		[DossierMedical:29]DM_Age:15:=Uut_HébergéAgePlus(->[DossierMedical:29]DM_DateNéLe:16; ->[DossierMedical:29]DM_Date:4)
		[DossierMedical:29]DM_Genre:18:=(x_IDTG_1=0)
	End if 
	va_Identité:=[DossierMedical:29]DM_Nom:13+" "+[DossierMedical:29]DM_Prénom:14
	P_ChampAttribut(<>vlSTR_DM-<>vlSTR)
End if 
