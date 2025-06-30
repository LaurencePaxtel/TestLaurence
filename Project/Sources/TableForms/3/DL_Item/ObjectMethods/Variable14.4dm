If (Size of array:C274(<>ta_TBItem)>0)
	If (<>ta_TBItem>0)
		ve_PosTB:=<>ta_TBItem
		Case of 
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_EtatCivil:20))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBEtCiv; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Signalement:12))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBSglt; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Nationalité:25))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBNatio; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_SituFamille:29))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBSitFam; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Orientation1:58))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBOr1; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Orientation2:60))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBOr2; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_AutreSolutio:88))
				Tab_PopIn(<>ta_TBItem; -><>ta_AtS; ->va_IDT_Typ1)
				
				
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DateNéLe:24))
				ARRAY TEXT:C222(<>ta_TBItem; 0)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_PiècesIdté1:31))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBPIdté; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_CodePostal:14))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBArr; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Gare:15))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBGare; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Métro:16))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBMetro; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Lien:18))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBLien; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_TempsErrance:34))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBTpsErr; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DernierHéber:35))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBDerHéb; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_SituProfess:36))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBSitPro; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DernierEmplo:37))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBDerJob; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DuréSanEmplo:38))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBDurJob; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_RupMajeur1:40))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBRupMaj; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Ressources1:45))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBResAct; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_SuiviSocial1:49))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBSuiSoc; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_CouvSocial1:53))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBCouSoc; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_NiveauEtude:43))
				Tab_PopIn(<>ta_TBItem; -><>ta_TBNivEtu; ->va_IDT_Typ1)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_FamGroupe:102))
				Tab_PopIn(<>ta_TBItem; -><>ta_FMGrp; ->va_IDT_Typ1)
				
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Plateforme:139))
				Tab_PopIn(<>ta_TBItem; -><>ta_Plateforme; ->va_IDT_Typ1)
				
				
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Permanencier:9))
				Tab_PopIn(<>ta_TBItem; -><>ta_InPerm; ->va_IDT_Typ1)
				
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_FamClé:104))
				ARRAY TEXT:C222(<>ta_TBItem; 0)
				
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Coordinateur:7))
				Tab_PopIn(<>ta_TBItem; -><>ta_InCoo; ->va_IDT_Typ1)
				
				
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DossierSIAO:164))
				Tab_PopIn(<>ta_TBItem; -><>ta_HG_DosSIAO; ->va_IDT_Typ1)
				
				
		End case 
	Else 
		<>ta_TBItem:=ve_PosTB
	End if 
End if 