//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_Coordinateur
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($ii)
Case of 
	: ($1=0)  //•••••••••••••••••••Déclaration
		C_TEXT:C284(va_TailCtr)
		va_TailCtr:=""
		C_LONGINT:C283($TailleTab)
		
		$TailleTab:=Size of array:C274(<>ta_TBEtCiv)
		ARRAY LONGINT:C221(t_ET_Dem; $TailleTab)
		C_LONGINT:C283(vl_ET_Dem)
		ARRAY REAL:C219(t_ET_DemPc; $TailleTab)
		C_REAL:C285(vr_ET_DemPc)
		ARRAY LONGINT:C221(t_ET_Dis; $TailleTab)
		C_LONGINT:C283(vl_ET_Dis)
		ARRAY REAL:C219(t_ET_DisPc; $TailleTab)
		C_REAL:C285(vr_ET_DisPc)
		ARRAY LONGINT:C221(t_ET_Med; $TailleTab)
		C_LONGINT:C283(vl_ET_Med)
		ARRAY REAL:C219(t_ET_MedPc; $TailleTab)
		C_REAL:C285(vr_ET_MedPc)
		
		$TailleTab:=Size of array:C274(<>ta_TBSglt)
		ARRAY LONGINT:C221(t_SG_Dem; $TailleTab)
		C_LONGINT:C283(vl_SG_Dem)
		ARRAY REAL:C219(t_SG_DemPc; $TailleTab)
		C_REAL:C285(vr_SG_DemPc)
		
		ALL RECORDS:C47([LesCentres:9])
		MultiSoc_Filter(->[LesCentres:9])
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		//Ligne suivante modifiée le 13 janv 99
		//Ajout de la capacité du centre
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; t_CT_ID; [LesCentres:9]LC_Nom:4; ta_Centre; [LesCentres:9]LC_DispoNuit:22; t_CT_Capa)
		$TailleTab:=Size of array:C274(ta_Centre)
		
		ARRAY LONGINT:C221(t_CT_Col; $TailleTab)
		ARRAY INTEGER:C220(te_Centre; $TailleTab)
		If ($TailleTab>0)
			For ($ii; 1; $TailleTab)
				te_Centre{$ii}:=1
			End for 
		End if 
		va_TailCtr:=String:C10($TailleTab)+" \\ "+String:C10($TailleTab)
		C_LONGINT:C283(vl_CT_Col)
		
		C_LONGINT:C283(vl_1; vl_2; vl_3; vl_4; vl_5; vl_6; vl_7; vl_8; vl_9; vl_10; vl_11; vl_12; vl_13)
		//Ligne suivante modifiée le 13 janv 99
		//Nouvelles variables
		C_LONGINT:C283(vl_14; vl_15; vl_16; vl_17; vl_18; vl_19; vl_20; vl_21)
		C_LONGINT:C283(vl_t1; vl_t2; vl_t3; vl_t4; vl_t5; vl_t6; vl_t7; vl_t8; vl_t9; vl_t10; vl_t11; vl_t12; vl_t13)
		C_LONGINT:C283(vl_t14; vl_t15; vl_t16; vl_t17; vl_t18; vl_t19; vl_t20; vl_t21)
		C_LONGINT:C283(vl_tx1; vl_tx2; vl_tx3; vl_tx4; vl_tx5; vl_tx6; vl_tx7; vl_tx8; vl_tx9; vl_tx10; vl_tx11; vl_tx12; vl_tx13)
		C_LONGINT:C283(vl_tx14; vl_tx15; vl_tx16; vl_tx17; vl_tx18; vl_tx19; vl_tx20; vl_tx21)
		
		ARRAY LONGINT:C221(t_CT_SHom; $TailleTab)
		ARRAY LONGINT:C221(t_CT_CHom; $TailleTab)
		ARRAY LONGINT:C221(t_CT_EHom; $TailleTab)
		ARRAY LONGINT:C221(t_CT_FHom; $TailleTab)
		C_LONGINT:C283(vl_CT_SHom)
		C_LONGINT:C283(vl_CT_CHom)
		C_LONGINT:C283(vl_CT_EHom)
		C_LONGINT:C283(vl_CT_FHom)
		
		ARRAY LONGINT:C221(t_CT_SFem; $TailleTab)
		ARRAY LONGINT:C221(t_CT_CFem; $TailleTab)
		ARRAY LONGINT:C221(t_CT_EFem; $TailleTab)
		ARRAY LONGINT:C221(t_CT_FFem; $TailleTab)
		C_LONGINT:C283(vl_CT_SFem)
		C_LONGINT:C283(vl_CT_CFem)
		C_LONGINT:C283(vl_CT_EFem)
		C_LONGINT:C283(vl_CT_FFem)
		
		ARRAY LONGINT:C221(t_CT_PMin; $TailleTab)
		ARRAY LONGINT:C221(t_CT_MMin; $TailleTab)
		C_LONGINT:C283(vl_CT_PMin)
		C_LONGINT:C283(vl_CT_MMin)
		
		ARRAY LONGINT:C221(t_CT_Total; $TailleTab)
		C_LONGINT:C283(vl_CT_Total)
		
		ARRAY LONGINT:C221(t_CT_Dis; $TailleTab)
		C_LONGINT:C283(vl_CT_Dis)
		
		ARRAY LONGINT:C221(t_CT_Rest; $TailleTab)
		C_LONGINT:C283(vl_CT_Rest)
		
		//Lignes suivantes modifiée le 13 janv 99
		//Nouvelles variables tableaux et entier long
		ARRAY LONGINT:C221(t_CT_SGrép; $TailleTab)
		C_LONGINT:C283(vl_CT_SGrép)
		
		ARRAY LONGINT:C221(t_CT_DisJ; $TailleTab)
		C_LONGINT:C283(vl_CT_DisJ)
		
		ARRAY LONGINT:C221(t_CT_SGas; $TailleTab)
		C_LONGINT:C283(vl_CT_SGas)
		
		ARRAY LONGINT:C221(t_CT_SGmd; $TailleTab)
		C_LONGINT:C283(vl_CT_SGmd)
		
		//TABLEAU ENTIER LONG(t_CT_Capa;$TailleTab)
		C_LONGINT:C283(vl_CT_Capa)
		
		ARRAY LONGINT:C221(t_CT_Abs; $TailleTab)
		C_LONGINT:C283(vl_CT_Abs)
		
		ARRAY LONGINT:C221(t_CT_DistA; $TailleTab)
		C_LONGINT:C283(vl_CT_DistA)
		
		ARRAY LONGINT:C221(t_CT_Lat; $TailleTab)
		C_LONGINT:C283(vl_CT_Lat)
		
		//Fin Lignes suivantes Nouvelles variables tab et Long int
		
		$TailleTab:=Size of array:C274(<>ta_TBOr1)
		ARRAY LONGINT:C221(t_OR1_Hom; $TailleTab)
		C_LONGINT:C283(vl_OR1_Hom)
		ARRAY LONGINT:C221(t_OR1_Fem; $TailleTab)
		C_LONGINT:C283(vl_OR1_Fem)
		ARRAY LONGINT:C221(t_OR1_Total; $TailleTab)
		C_LONGINT:C283(vl_OR1_Tot)
		ARRAY REAL:C219(t_OR1_Pc; $TailleTab)
		C_REAL:C285(vr_OR1_Pc)
		
		$TailleTab:=Size of array:C274(<>ta_TBOr2)
		ARRAY LONGINT:C221(t_OR2_Hom; $TailleTab)
		C_LONGINT:C283(vl_OR2_Hom)
		ARRAY LONGINT:C221(t_OR2_Fem; $TailleTab)
		C_LONGINT:C283(vl_OR2_Fem)
		ARRAY LONGINT:C221(t_OR2_Total; $TailleTab)
		C_LONGINT:C283(vl_OR2_Tot)
		ARRAY REAL:C219(t_OR2_Pc; $TailleTab)
		C_REAL:C285(vr_OR2_Pc)
		
		$TailleTab:=Size of array:C274(<>ta_AtS)
		ARRAY LONGINT:C221(t_AtS_Hom; $TailleTab)
		C_LONGINT:C283(vl_AtS_Hom)
		ARRAY LONGINT:C221(t_AtS_Fem; $TailleTab)
		C_LONGINT:C283(vl_AtS_Fem)
		ARRAY LONGINT:C221(t_AtS_Total; $TailleTab)
		C_LONGINT:C283(vl_AtS_Tot)
		ARRAY REAL:C219(t_AtS_Pc; $TailleTab)
		C_REAL:C285(vr_AtS_Pc)
		
		$TailleTab:=Size of array:C274(<>ta_TBMaraud)
		ARRAY LONGINT:C221(t_Mar_Hom; $TailleTab)
		C_LONGINT:C283(vl_Mar_Hom)
		ARRAY LONGINT:C221(t_Mar_Fem; $TailleTab)
		C_LONGINT:C283(vl_Mar_Fem)
		ARRAY LONGINT:C221(t_TBMarTot; $TailleTab)
		C_LONGINT:C283(vl_Mar_Tot)
		ARRAY REAL:C219(t_Mar_Pc; $TailleTab)
		C_REAL:C285(vr_Mar_Pc)
		
		//Prestations
		$TailleTab:=Size of array:C274(<>ta_DemP)
		ARRAY LONGINT:C221(t_DP_Dem; $TailleTab)
		ARRAY LONGINT:C221(t_DP_Dem1; $TailleTab)
		ARRAY LONGINT:C221(t_DP_Dem2; $TailleTab)
		ARRAY LONGINT:C221(t_DP_Dem3; $TailleTab)
		C_LONGINT:C283(vl_DP_Dem; vl_DP_Dem1; vl_DP_Dem2; vl_DP_Dem3)
		ARRAY REAL:C219(t_DP_DemPc; $TailleTab)
		C_REAL:C285(vr_DP_DemPc)
		
		$TailleTab:=Size of array:C274(<>ta_AdUtil)
		ARRAY LONGINT:C221(t_AU_Dem; $TailleTab)
		ARRAY LONGINT:C221(t_AU_Dem1; $TailleTab)
		ARRAY LONGINT:C221(t_AU_Dem2; $TailleTab)
		ARRAY LONGINT:C221(t_AU_Dem3; $TailleTab)
		C_LONGINT:C283(vl_AU_Dem; vl_AU_Dem1; vl_AU_Dem2; vl_AU_Dem3)
		ARRAY REAL:C219(t_AU_DemPc; $TailleTab)
		C_REAL:C285(vr_AU_DemPc)
		
		$TailleTab:=Size of array:C274(<>ta_SitPar)
		ARRAY LONGINT:C221(t_SP_Dem; $TailleTab)
		ARRAY LONGINT:C221(t_SP_Dem1; $TailleTab)
		ARRAY LONGINT:C221(t_SP_Dem2; $TailleTab)
		ARRAY LONGINT:C221(t_SP_Dem3; $TailleTab)
		C_LONGINT:C283(vl_SP_Dem; vl_SP_Dem1; vl_SP_Dem2; vl_SP_Dem3)
		ARRAY REAL:C219(t_SP_DemPc; $TailleTab)
		C_REAL:C285(vr_SP_DemPc)
		
		ARRAY TEXT:C222(ta_Ass; 0)
		ARRAY LONGINT:C221(t_AS_Dem; 0)
		ARRAY LONGINT:C221(t_AS_Dem1; 0)
		ARRAY LONGINT:C221(t_AS_Dem2; 0)
		ARRAY LONGINT:C221(t_AS_Dem3; 0)
		C_LONGINT:C283(vl_AS_Dem; vl_AS_Dem1; vl_AS_Dem2; vl_AS_Dem3)
		ARRAY REAL:C219(t_AS_DemPc; 0)
		C_REAL:C285(vr_AS_DemPc)
		
		$TailleTab:=0
		ARRAY TEXT:C222(ta_PrestDem; $TailleTab)
		C_LONGINT:C283(vl_Prest)
		ARRAY LONGINT:C221(t_Prest; $TailleTab)
		C_REAL:C285(vr_PrestPc)
		
		//Fin des tableaux de prestation
		
		//Prestations Type 2
		$TailleTab:=0  //Taille tableau(◊ta_DemP)
		ARRAY TEXT:C222(ta_DemP_N; $TailleTab)
		ARRAY LONGINT:C221(tl_DemPt_N; $TailleTab)
		ARRAY LONGINT:C221(tl_DemPt1_N; $TailleTab)
		ARRAY LONGINT:C221(tl_DemPt2_N; $TailleTab)
		ARRAY LONGINT:C221(tl_DemPt3_N; $TailleTab)
		C_LONGINT:C283(vl_DP_Dem_N; vl_DP_Dem1_N; vl_DP_Dem2_N; vl_DP_Dem3_N)
		ARRAY REAL:C219(t_DP_DemPc_N; $TailleTab)
		C_REAL:C285(vr_DP_DemPc_N)
		
		
		$TailleTab:=0  //Taille tableau(◊ta_AdUtil)
		ARRAY TEXT:C222(ta_AdUtil_N; $TailleTab)
		ARRAY LONGINT:C221(tl_AdUPt_N; $TailleTab)
		ARRAY LONGINT:C221(tl_AdUPt1_N; $TailleTab)
		ARRAY LONGINT:C221(tl_AdUPt2_N; $TailleTab)
		ARRAY LONGINT:C221(tl_AdUPt3_N; $TailleTab)
		C_LONGINT:C283(vl_AU_Dem_N; vl_AU_Dem1_N; vl_AU_Dem2_N; vl_AU_Dem3_N)
		ARRAY REAL:C219(t_AU_DemPc_N; $TailleTab)
		C_REAL:C285(vr_AU_DemPc_N)
		
		
		$TailleTab:=0  //Taille tableau(◊ta_SitPar)
		ARRAY TEXT:C222(ta_SitPar_N; $TailleTab)
		ARRAY LONGINT:C221(tl_SitPt_N; $TailleTab)
		ARRAY LONGINT:C221(tl_SitPt1_N; $TailleTab)
		ARRAY LONGINT:C221(tl_SitPt2_N; $TailleTab)
		ARRAY LONGINT:C221(tl_SitPt3_N; $TailleTab)
		C_LONGINT:C283(vl_SP_Dem_N; vl_SP_Dem1_N; vl_SP_Dem2_N; vl_SP_Dem3_N)
		ARRAY REAL:C219(t_SP_DemPc_N; $TailleTab)
		C_REAL:C285(vr_SP_DemPc_N)
		
		
		ARRAY TEXT:C222(ta_Ass_N; 0)
		ARRAY LONGINT:C221(t_AS_Dem_N; 0)
		ARRAY LONGINT:C221(t_AS_Dem1_N; 0)
		ARRAY LONGINT:C221(t_AS_Dem2_N; 0)
		ARRAY LONGINT:C221(t_AS_Dem3_N; 0)
		C_LONGINT:C283(vl_AS_Dem_N; vl_AS_Dem1_N; vl_AS_Dem2_N; vl_AS_Dem3_N)
		ARRAY REAL:C219(t_AS_DemPc_N; 0)
		C_REAL:C285(vr_AS_DemPc_N)
		
		$TailleTab:=0
		ARRAY TEXT:C222(ta_PrestDem_N; $TailleTab)
		C_LONGINT:C283(vl_Prest_N)
		ARRAY LONGINT:C221(t_Prest_N; $TailleTab)
		C_REAL:C285(vr_PrestPc_N)
		
		//Fin des tableaux de prestation type 2
		
		
		//Prestations Type 3
		ARRAY TEXT:C222(ta_DemP; 0)
		ARRAY LONGINT:C221(tl_DemPt; 0)
		ARRAY LONGINT:C221(tl_DemPt1; 0)
		ARRAY LONGINT:C221(tl_DemPt2; 0)
		ARRAY LONGINT:C221(tl_DemPt3; 0)
		
		ARRAY TEXT:C222(ta_AdUtil; 0)
		ARRAY LONGINT:C221(tl_AdUPt; 0)
		ARRAY LONGINT:C221(tl_AdUPt1; 0)
		ARRAY LONGINT:C221(tl_AdUPt2; 0)
		ARRAY LONGINT:C221(tl_AdUPt3; 0)
		
		ARRAY TEXT:C222(ta_SitPar; 0)
		ARRAY LONGINT:C221(tl_SitPt; 0)
		ARRAY LONGINT:C221(tl_SitPt1; 0)
		ARRAY LONGINT:C221(tl_SitPt2; 0)
		ARRAY LONGINT:C221(tl_SitPt3; 0)
		//Fin des tableaux de prestation type 3
		
		C_TEXT:C284(vt_StTexte)
		//Lignes suivantes créées le 23 oct 2000
		
		$TailleTab:=Size of array:C274(<>ta_FMCaS)
		ARRAY LONGINT:C221(tl_FMCaS; $TailleTab)
		C_LONGINT:C283(vl_FMCaS)
		
		$TailleTab:=Size of array:C274(<>ta_FMDis1)
		ARRAY LONGINT:C221(tl_FMDis1; $TailleTab)
		C_LONGINT:C283(vl_FMDis1)
		
		$TailleTab:=Size of array:C274(<>ta_FMDis2)
		ARRAY LONGINT:C221(tl_FMDis2; $TailleTab)
		C_LONGINT:C283(vl_FMDis2)
		
		$TailleTab:=Size of array:C274(<>ta_FMDis3)
		ARRAY LONGINT:C221(tl_FMDis3; $TailleTab)
		C_LONGINT:C283(vl_FMDis3)
		
		$TailleTab:=Size of array:C274(<>ta_FMDis4)
		ARRAY LONGINT:C221(tl_FMDis4; $TailleTab)
		C_LONGINT:C283(vl_FMDis4)
		
		$TailleTab:=Size of array:C274(<>ta_FMDis5)
		ARRAY LONGINT:C221(tl_FMDis5; $TailleTab)
		C_LONGINT:C283(vl_FMDis5)
		
		
		//26/01/2004
		$TailleTab:=Size of array:C274(<>ta_FMDis1)
		ARRAY REAL:C219(tr_FMDis1; $TailleTab)
		C_LONGINT:C283(vr_FMDis1)
		
		$TailleTab:=Size of array:C274(<>ta_FMDis2)
		ARRAY LONGINT:C221(tr_FMDis2; $TailleTab)
		C_LONGINT:C283(vr_FMDis2)
		
		$TailleTab:=Size of array:C274(<>ta_FMDis3)
		ARRAY LONGINT:C221(tr_FMDis3; $TailleTab)
		C_LONGINT:C283(vr_FMDis3)
		
		$TailleTab:=Size of array:C274(<>ta_FMDis4)
		ARRAY LONGINT:C221(tr_FMDis4; $TailleTab)
		C_LONGINT:C283(vr_FMDis4)
		
		$TailleTab:=Size of array:C274(<>ta_FMDis5)
		ARRAY LONGINT:C221(tr_FMDis5; $TailleTab)
		C_LONGINT:C283(vr_FMDis5)
		//fin 26/01/2004
		
		//$TailleTab:=Taille tableau(◊ta_FMComp)
		$TailleTab:=0
		ARRAY LONGINT:C221(tl_FMComp; $TailleTab)
		ARRAY LONGINT:C221(tl_FMCompNC; $TailleTab)
		ARRAY LONGINT:C221(tl_FMCompC; $TailleTab)
		ARRAY REAL:C219(tr_FMComp; $TailleTab)
		C_LONGINT:C283(vl_FMComp)
		C_LONGINT:C283(vl_FMCompNC)
		C_LONGINT:C283(vl_FMCompC)
		C_REAL:C285(vr_FMComp)
		
		
	: ($1=1)  //•••••••••••••••••••Mise à zéro
		
		C_LONGINT:C283($TailleTab)
		
		
		$TailleTab:=Size of array:C274(<>ta_TBEtCiv)
		For ($ii; 1; $TailleTab)
			t_ET_Dem{$ii}:=0
			t_ET_DemPc{$ii}:=0
			t_ET_Dis{$ii}:=0
			t_ET_DisPc{$ii}:=0
			t_ET_Med{$ii}:=0
			t_ET_MedPc{$ii}:=0
		End for 
		vl_ET_Dem:=0
		vr_ET_DemPc:=0
		vl_ET_Dis:=0
		vr_ET_DisPc:=0
		vl_ET_Med:=0
		vr_ET_MedPc:=0
		
		$TailleTab:=Size of array:C274(<>ta_TBSglt)
		For ($ii; 1; $TailleTab)
			t_SG_Dem{$ii}:=0
			t_SG_DemPc{$ii}:=0
		End for 
		vl_SG_Dem:=0
		vr_SG_DemPc:=0
		
		$TailleTab:=Size of array:C274(ta_Centre)
		For ($ii; 1; $TailleTab)
			t_CT_Col{$ii}:=0
			t_CT_SHom{$ii}:=0
			t_CT_CHom{$ii}:=0
			t_CT_EHom{$ii}:=0
			t_CT_FHom{$ii}:=0
			t_CT_SFem{$ii}:=0
			t_CT_CFem{$ii}:=0
			t_CT_EFem{$ii}:=0
			t_CT_FFem{$ii}:=0
			t_CT_PMin{$ii}:=0
			t_CT_MMin{$ii}:=0
			t_CT_Total{$ii}:=0
			t_CT_Dis{$ii}:=0
			t_CT_Rest{$ii}:=0
			
			t_CT_SGrép{$ii}:=0
			t_CT_SGas{$ii}:=0
			t_CT_SGmd{$ii}:=0
			t_CT_Abs{$ii}:=0
			t_CT_Lat{$ii}:=0
			t_CT_DistA{$ii}:=0
			t_CT_DisJ{$ii}:=0
		End for 
		C_LONGINT:C283(vl_CT_Col)
		
		
		vl_1:=0
		vl_2:=0
		vl_3:=0
		vl_4:=0
		vl_5:=0
		vl_6:=0
		vl_7:=0
		vl_8:=0
		vl_9:=0
		vl_10:=0
		vl_11:=0
		vl_12:=0
		vl_13:=0
		
		
		vl_14:=0
		vl_15:=0
		vl_16:=0
		vl_17:=0
		vl_18:=0
		vl_19:=0
		vl_20:=0
		vl_21:=0
		
		vl_tx1:=0
		vl_tx2:=0
		vl_tx3:=0
		vl_tx4:=0
		vl_tx5:=0
		vl_tx6:=0
		vl_tx7:=0
		vl_tx8:=0
		vl_tx9:=0
		vl_tx10:=0
		vl_tx11:=0
		vl_tx12:=0
		vl_tx13:=0
		
		vl_tx14:=0
		vl_tx15:=0
		vl_tx16:=0
		
		vl_tx17:=0
		vl_tx18:=0
		vl_tx19:=0
		vl_tx20:=0
		vl_tx21:=0
		
		vl_CT_SHom:=0
		vl_CT_CHom:=0
		vl_CT_EHom:=0
		vl_CT_FHom:=0
		
		vl_CT_SFem:=0
		vl_CT_CFem:=0
		vl_CT_EFem:=0
		vl_CT_FFem:=0
		
		vl_CT_PMin:=0
		vl_CT_MMin:=0
		
		vl_CT_Total:=0
		
		vl_CT_Dis:=0
		
		vl_CT_Rest:=0
		
		vl_CT_SGrép:=0
		vl_CT_SGas:=0
		vl_CT_SGmd:=0
		
		vl_CT_Capa:=0
		vl_CT_Abs:=0
		vl_CT_DisJ:=0
		vl_CT_DistA:=0
		vl_CT_Lat:=0
		
		$TailleTab:=Size of array:C274(<>ta_TBOr1)
		For ($ii; 1; $TailleTab)
			t_OR1_Hom{$ii}:=0
			t_OR1_Fem{$ii}:=0
			t_OR1_Total{$ii}:=0
			t_OR1_Pc{$ii}:=0
		End for 
		vl_OR1_Hom:=0
		vl_OR1_Fem:=0
		vl_OR1_Tot:=0
		vr_OR1_Pc:=0
		
		$TailleTab:=Size of array:C274(<>ta_TBOr2)
		For ($ii; 1; $TailleTab)
			t_OR2_Hom{$ii}:=0
			t_OR2_Fem{$ii}:=0
			t_OR2_Total{$ii}:=0
			t_OR2_Pc{$ii}:=0
		End for 
		vl_OR2_Hom:=0
		vl_OR2_Fem:=0
		vl_OR2_Tot:=0
		vr_OR2_Pc:=0
		
		$TailleTab:=Size of array:C274(<>ta_AtS)
		For ($ii; 1; $TailleTab)
			t_AtS_Hom{$ii}:=0
			t_AtS_Fem{$ii}:=0
			t_AtS_Total{$ii}:=0
			t_AtS_Pc{$ii}:=0
		End for 
		vl_AtS_Hom:=0
		vl_AtS_Fem:=0
		vl_AtS_Tot:=0
		vr_AtS_Pc:=0
		
		
		$TailleTab:=Size of array:C274(<>ta_TBMaraud)
		For ($ii; 1; $TailleTab)
			t_Mar_Hom{$ii}:=0
			t_Mar_Fem{$ii}:=0
			t_TBMarTot{$ii}:=0
			t_Mar_Pc{$ii}:=0
		End for 
		vl_Mar_Hom:=0
		vl_Mar_Fem:=0
		vl_Mar_Tot:=0
		vr_Mar_Pc:=0
		
		
		//Les tableaux de prestation
		$TailleTab:=Size of array:C274(<>ta_DemP)
		For ($ii; 1; $TailleTab)
			t_DP_Dem{$ii}:=0
			t_DP_Dem1{$ii}:=0
			t_DP_Dem2{$ii}:=0
			t_DP_Dem3{$ii}:=0
			t_DP_DemPc{$ii}:=0
		End for 
		vl_DP_Dem:=0
		vl_DP_Dem1:=0
		vl_DP_Dem2:=0
		vl_DP_Dem3:=0
		vr_DP_DemPc:=0
		
		$TailleTab:=Size of array:C274(<>ta_AdUtil)
		For ($ii; 1; $TailleTab)
			t_AU_Dem{$ii}:=0
			t_AU_Dem1{$ii}:=0
			t_AU_Dem2{$ii}:=0
			t_AU_Dem3{$ii}:=0
			t_AU_DemPc{$ii}:=0
		End for 
		vl_AU_Dem:=0
		vl_AU_Dem1:=0
		vl_AU_Dem2:=0
		vl_AU_Dem3:=0
		vr_AU_DemPc:=0
		
		$TailleTab:=Size of array:C274(<>ta_SitPar)
		For ($ii; 1; $TailleTab)
			t_SP_Dem{$ii}:=0
			t_SP_Dem1{$ii}:=0
			t_SP_Dem2{$ii}:=0
			t_SP_Dem3{$ii}:=0
			t_SP_DemPc{$ii}:=0
		End for 
		vl_SP_Dem:=0
		vl_SP_Dem1:=0
		vl_SP_Dem2:=0
		vl_SP_Dem3:=0
		vr_SP_DemPc:=0
		
		ARRAY TEXT:C222(ta_Ass; 0)
		ARRAY LONGINT:C221(t_AS_Dem; 0)
		C_LONGINT:C283(vl_AS_Dem)
		ARRAY REAL:C219(t_AS_DemPc; 0)
		C_REAL:C285(vr_AS_DemPc)
		//des tableaux de prestation
		vl_AS_Dem:=0
		vl_AS_Dem1:=0
		vl_AS_Dem2:=0
		vl_AS_Dem3:=0
		
		
		
		
		//Les tableaux de prestationtype 2   
		$TailleTab:=Size of array:C274(ta_DemP_N)
		For ($ii; 1; $TailleTab)
			tl_DemPt_N{$ii}:=0
			tl_DemPt1_N{$ii}:=0
			tl_DemPt2_N{$ii}:=0
			tl_DemPt3_N{$ii}:=0
			t_DP_DemPc_N{$ii}:=0
		End for 
		vl_DP_Dem_N:=0
		vl_DP_Dem1_N:=0
		vl_DP_Dem2_N:=0
		vl_DP_Dem3_N:=0
		vr_DP_DemPc_N:=0
		
		$TailleTab:=Size of array:C274(ta_AdUtil_N)
		For ($ii; 1; $TailleTab)
			tl_AdUPt_N{$ii}:=0
			tl_AdUPt1_N{$ii}:=0
			tl_AdUPt2_N{$ii}:=0
			tl_AdUPt3_N{$ii}:=0
			t_AU_DemPc_N{$ii}:=0
		End for 
		vl_AU_Dem_N:=0
		vl_AU_Dem1_N:=0
		vl_AU_Dem2_N:=0
		vl_AU_Dem3_N:=0
		vr_AU_DemPc_N:=0
		
		
		$TailleTab:=Size of array:C274(ta_SitPar_N)
		For ($ii; 1; $TailleTab)
			tl_SitPt_N{$ii}:=0
			tl_SitPt1_N{$ii}:=0
			tl_SitPt2_N{$ii}:=0
			tl_SitPt3_N{$ii}:=0
			t_SP_DemPc_N{$ii}:=0
		End for 
		vl_SP_Dem_N:=0
		vl_SP_Dem1_N:=0
		vl_SP_Dem2_N:=0
		vl_SP_Dem3_N:=0
		vr_SP_DemPc_N:=0
		
		$TailleTab:=Size of array:C274(ta_Ass_N)
		For ($ii; 1; $TailleTab)
			t_AS_Dem_N{$ii}:=0
			t_AS_Dem1_N{$ii}:=0
			t_AS_Dem2_N{$ii}:=0
			t_AS_Dem3_N{$ii}:=0
			t_AS_DemPc_N{$ii}:=0
		End for 
		vl_AS_Dem_N:=0
		vl_AS_Dem1_N:=0
		vl_AS_Dem2_N:=0
		vl_AS_Dem3_N:=0
		vr_AS_DemPc_N:=0
		//des tableaux de prestation type 2
		
		
		$TailleTab:=Size of array:C274(ta_xGroupe)
		For ($ii; 1; $TailleTab)
			tl_xGroupe{$ii}:=0
		End for 
		vl_xGroupe:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMCaS)
		For ($ii; 1; $TailleTab)
			tl_FMCaS{$ii}:=0
		End for 
		vl_FMCaS:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMDis1)
		For ($ii; 1; $TailleTab)
			tl_FMDis1{$ii}:=0
		End for 
		vl_FMDis1:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMDis2)
		For ($ii; 1; $TailleTab)
			tl_FMDis2{$ii}:=0
		End for 
		vl_FMDis2:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMDis3)
		For ($ii; 1; $TailleTab)
			tl_FMDis3{$ii}:=0
		End for 
		vl_FMDis3:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMDis4)
		For ($ii; 1; $TailleTab)
			tl_FMDis4{$ii}:=0
		End for 
		vl_FMDis4:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMDis5)
		For ($ii; 1; $TailleTab)
			tl_FMDis5{$ii}:=0
		End for 
		vl_FMDis5:=0
		
		//26/01/2004
		$TailleTab:=Size of array:C274(<>ta_FMDis1)
		For ($ii; 1; $TailleTab)
			tr_FMDis1{$ii}:=0
		End for 
		vr_FMDis1:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMDis2)
		For ($ii; 1; $TailleTab)
			tr_FMDis2{$ii}:=0
		End for 
		vr_FMDis2:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMDis3)
		For ($ii; 1; $TailleTab)
			tr_FMDis3{$ii}:=0
		End for 
		vr_FMDis3:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMDis4)
		For ($ii; 1; $TailleTab)
			tr_FMDis4{$ii}:=0
		End for 
		vr_FMDis4:=0
		
		$TailleTab:=Size of array:C274(<>ta_FMDis5)
		For ($ii; 1; $TailleTab)
			tr_FMDis5{$ii}:=0
		End for 
		vr_FMDis5:=0
		//fin 26/01/2004
		
		
		$TailleTab:=0
		For ($ii; 1; $TailleTab)
			tl_FMComp{$ii}:=0
			tl_FMCompNC{$ii}:=0
			tl_FMCompC{$ii}:=0
			tr_FMComp{$ii}:=0
		End for 
		vl_FMComp:=0
		vl_FMCompNC:=0
		vl_FMCompC:=0
		vr_FMComp:=0
		
End case 