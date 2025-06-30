If (Form event code:C388=Sur chargement:K2:1)
	vl_RéfList:=Load list:C383("TabSanté")
	vb_MRferme:=False:C215
	
	If (Is new record:C668([DossierSante:33]))
		MultiSoc_Init_Structure(->[DossierSante:33])
		[DossierSante:33]DE_Référence:1:=Uut_Numerote(->[DossierSante:33])
		[DossierSante:33]DE_Date:4:=Current date:C33(*)
		[DossierSante:33]DE_Heure:5:=Current time:C178(*)
		[DossierSante:33]DE_FicheNuméro:3:=Uut_NumeroteDossier("DE"; [DossierSante:33]DE_Date:4)
		va_Identité:=""
		
		[DossierSante:33]DE_Opérateur:8:=Current user:C182
		[DossierSante:33]DE_HB_ID:10:=vl_RéfU_HBB
		[DossierSante:33]DE_EtatCivil:13:=va_IDT_Typ1
		[DossierSante:33]DE_Nom:14:=va_IDT_Nom
		[DossierSante:33]DE_Prénom:15:=va_IDT_Pré
		[DossierSante:33]DE_DateNéLe:17:=vd_IDT_NéLe
		[DossierSante:33]DE_Age:16:=Uut_HébergéAgePlus(->[DossierSante:33]DE_DateNéLe:17; ->[DossierSante:33]DE_Date:4)
		[DossierSante:33]DE_Genre:19:=(x_IDTG_1=0)
		
		[DossierSante:33]DE_EntréeDate:62:=Current date:C33
		[DossierSante:33]DE_EntréeHeure:63:=Current time:C178
		
		V_DosSanté_Déc(4)
		P_DS_SavePrescription(0)
	Else 
		P_DS_SavePrescription(2)
	End if 
	
	vt_TempObs:=""
	vt_TempTrans:=""
	vt_TempPans:=""
	vt_TempAS:=""
	
	va_Identité:=[DossierSante:33]DE_Nom:14+" "+[DossierSante:33]DE_Prénom:15
	P_ChampAttribut(<>vlSTR_DE-<>vlSTR)
End if 