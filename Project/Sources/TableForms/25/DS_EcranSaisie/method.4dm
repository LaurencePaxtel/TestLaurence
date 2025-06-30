If (Form event code:C388=Sur chargement:K2:1)
	vb_MRferme:=False:C215
	If (Is new record:C668([DossierSocial:25]))
		[DossierSocial:25]DS_Référence:1:=Uut_Numerote(->[DossierSocial:25])
		[DossierSocial:25]DS_Date:4:=Current date:C33(*)
		[DossierSocial:25]DS_Heure:5:=Current time:C178(*)
		[DossierSocial:25]DS_FicheNuméro:3:=Uut_NumeroteDossier("DS"; [DossierSocial:25]DS_Date:4)
		va_Identité:=""
		[DossierSocial:25]DS_Opérateur:8:=Current user:C182
		[DossierSocial:25]DS_HB_ID:10:=vl_RéfU_HBB
		[DossierSocial:25]DS_EtatCivil:11:=va_IDT_Typ1
		[DossierSocial:25]DS_Nom:12:=va_IDT_Nom
		[DossierSocial:25]DS_Prénom:16:=va_IDT_Pré
		[DossierSocial:25]DS_DateNéLe:18:=vd_IDT_NéLe
		[DossierSocial:25]DS_Age:17:=Uut_HébergéAgePlus(->[DossierSocial:25]DS_DateNéLe:18; ->[DossierSocial:25]DS_Date:4)
		[DossierSocial:25]DS_Genre:20:=(x_IDTG_1=0)
		P_VarDS(2)
	End if 
	va_Identité:=[DossierSocial:25]DS_Nom:12+" "+[DossierSocial:25]DS_Prénom:16
	
	P_ChampAttribut(<>vlSTR_DS-<>vlSTR)
	If (User in group:C338(Current user:C182; <>Groupe_DosActSocial) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		OBJECT SET VISIBLE:C603(*; "ActionsSoc_Bt"; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*; "ActionsSoc_Bt"; False:C215)
	End if 
End if 