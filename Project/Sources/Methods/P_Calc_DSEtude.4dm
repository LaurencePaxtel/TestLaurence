//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_DSEtude
//{
//{          Mardi 24 mai 2005 à 14:40:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($Position; $vl_Pas; $vl_PasTable)
C_BOOLEAN:C305($TuCompte)


i_MessageSeul("Calcul en cours …")
If (<>vb_StopEven=False:C215)
	//remise à zero de valeurs
	V_Stat_DosSocEt(1; 0)
	
	CREATE EMPTY SET:C140([HeBerge:4]; "E_HBCompte")
	USE SET:C118("E_encours")
	$vl_PasTable:=Records in selection:C76([DossierSocial:25])
	$vl_Pas:=0
	
	ORDER BY:C49([DossierSocial:25]; [DossierSocial:25]DS_Date:4; <)
	FIRST RECORD:C50([DossierSocial:25])
	
	While ((Not:C34(End selection:C36([DossierSocial:25]))) & (<>vb_StopEven=False:C215))
		$vl_Pas:=$vl_Pas+1
		i_MessageSeul("Calcul en cours  : "+String:C10($vl_PasTable)+" / "+String:C10($vl_Pas))
		
		$TuCompte:=False:C215
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[DossierSocial:25]DS_HB_ID:10)
		MultiSoc_Filter(->[HeBerge:4])
		If (Records in selection:C76([HeBerge:4])=1)
			If (Is in set:C273("E_HBCompte"))
			Else 
				ADD TO SET:C119([HeBerge:4]; "E_HBCompte")
				$TuCompte:=True:C214
			End if 
		End if 
		
		If (sSexe=1)
			If ([DossierSocial:25]DS_Genre:20=True:C214)
				<>te_NbGenre{2}:=<>te_NbGenre{2}+1
				If ($TuCompte)
					<>tl_TBGenre{2}:=<>tl_TBGenre{2}+1
				End if 
			Else 
				<>te_NbGenre{1}:=<>te_NbGenre{1}+1
				If ($TuCompte)
					<>tl_TBGenre{1}:=<>tl_TBGenre{1}+1
				End if 
			End if 
		End if 
		
		If (sEtCv=1)
			$Position:=Find in array:C230(ta_FilexEtCiv; [DossierSocial:25]DS_EtatCivil:11)
			If ($Position>0)
				te_FileEtCivNb{$Position}:=te_FileEtCivNb{$Position}+1
				If ($TuCompte)
					tl_FileEtCivNb{$Position}:=tl_FileEtCivNb{$Position}+1
				End if 
			End if 
		End if 
		
		If (sAge=1)
			Case of 
					//0 à 3          
				: ([DossierSocial:25]DS_Age:17<=<>te_TBAge{1})
					<>te_NbAge{1}:=<>te_NbAge{1}+1
					If ($TuCompte)
						<>tl_NbAge{1}:=<>tl_NbAge{1}+1
					End if 
					//3 -18            
				: ([DossierSocial:25]DS_Age:17><>te_TBAge{1}) & ([DossierSocial:25]DS_Age:17<<>te_TBAge{2})
					<>te_NbAge{2}:=<>te_NbAge{2}+1
					If ($TuCompte)
						<>tl_NbAge{2}:=<>tl_NbAge{2}+1
					End if 
					// 19-24
				: ([DossierSocial:25]DS_Age:17>=<>te_TBAge{2}) & ([DossierSocial:25]DS_Age:17<=<>te_TBAge{3})
					<>te_NbAge{3}:=<>te_NbAge{3}+1
					If ($TuCompte)
						<>tl_NbAge{3}:=<>tl_NbAge{3}+1
					End if 
					//25-29
				: ([DossierSocial:25]DS_Age:17><>te_TBAge{3}) & ([DossierSocial:25]DS_Age:17<=<>te_TBAge{4})
					<>te_NbAge{4}:=<>te_NbAge{4}+1
					If ($TuCompte)
						<>tl_NbAge{4}:=<>tl_NbAge{4}+1
					End if 
					//30-39
				: ([DossierSocial:25]DS_Age:17><>te_TBAge{4}) & ([DossierSocial:25]DS_Age:17<=<>te_TBAge{5})
					<>te_NbAge{5}:=<>te_NbAge{5}+1
					If ($TuCompte)
						<>tl_NbAge{5}:=<>tl_NbAge{5}+1
					End if 
					//40-49
				: ([DossierSocial:25]DS_Age:17><>te_TBAge{5}) & ([DossierSocial:25]DS_Age:17<=<>te_TBAge{6})
					<>te_NbAge{6}:=<>te_NbAge{6}+1
					If ($TuCompte)
						<>tl_NbAge{6}:=<>tl_NbAge{6}+1
					End if 
					//50-59
				: ([DossierSocial:25]DS_Age:17><>te_TBAge{6}) & ([DossierSocial:25]DS_Age:17<=<>te_TBAge{7})
					<>te_NbAge{7}:=<>te_NbAge{7}+1
					If ($TuCompte)
						<>tl_NbAge{7}:=<>tl_NbAge{7}+1
					End if 
					//60-69
				: ([DossierSocial:25]DS_Age:17><>te_TBAge{7}) & ([DossierSocial:25]DS_Age:17<=<>te_TBAge{8})
					<>te_NbAge{8}:=<>te_NbAge{8}+1
					If ($TuCompte)
						<>tl_NbAge{8}:=<>tl_NbAge{8}+1
					End if 
					//+70
				: ([DossierSocial:25]DS_Age:17>=<>te_TBAge{9})
					<>te_NbAge{9}:=<>te_NbAge{9}+1
					If ($TuCompte)
						<>tl_NbAge{9}:=<>tl_NbAge{9}+1
					End if 
			End case 
		End if 
		
		If (sNatio=1)
			$Position:=Find in array:C230(<>ta_TBNatio; [DossierSocial:25]DS_Nationalité:22)
			If ($Position>0)
				te_NbNatio{$Position}:=te_NbNatio{$Position}+1
				If ($TuCompte)
					tl_NbNatio{$Position}:=tl_NbNatio{$Position}+1
				End if 
			End if 
		End if 
		
		If (sNeOu=1)
			$Position:=Find in array:C230(<>ta_TBLieuNé; [DossierSocial:25]DS_LieuNéOù:19)
			If ($Position>0)
				te_TBLieuNé{$Position}:=te_TBLieuNé{$Position}+1
				If ($TuCompte)
					tl_TBLieuNé{$Position}:=tl_TBLieuNé{$Position}+1
				End if 
			End if 
		End if 
		
		If (sLangue=1)
			$Position:=Find in array:C230(<>ta_Lgs; [DossierSocial:25]DS_Langue:23)
			If ($Position>0)
				te_Lgs{$Position}:=te_Lgs{$Position}+1
				If ($TuCompte)
					tl_Lgs{$Position}:=tl_Lgs{$Position}+1
				End if 
			End if 
		End if 
		
		If (sDerHb=1)
			$Position:=Find in array:C230(<>ta_DerLH; [DossierSocial:25]DS_DernierHéber:27)
			If ($Position>0)
				te_DerLH{$Position}:=te_DerLH{$Position}+1
				If ($TuCompte)
					tl_DerLH{$Position}:=tl_DerLH{$Position}+1
				End if 
			End if 
		End if 
		
		If (sCoSSp=1)
			$Position:=Find in array:C230(<>ta_MRCssp; [DossierSocial:25]DS_ConnuSSP:39)
			If ($Position>0)
				te_MRCssp{$Position}:=te_MRCssp{$Position}+1
				If ($TuCompte)
					tl_MRCssp{$Position}:=tl_MRCssp{$Position}+1
				End if 
			End if 
		End if 
		
		If (sMatri=1)
			$Position:=Find in array:C230(<>ta_TBSitFam; [DossierSocial:25]DS_EtatMatrimon:29)
			If ($Position>0)
				te_TBSitFam{$Position}:=te_TBSitFam{$Position}+1
				If ($TuCompte)
					tl_TBSitFam{$Position}:=tl_TBSitFam{$Position}+1
				End if 
			End if 
		End if 
		
		If (sEnfant=1)
			If ([DossierSocial:25]DS_Enfants:13=True:C214)
				<>te_TBEnfant{2}:=<>te_TBEnfant{2}+1
				If ($TuCompte)
					<>tl_TBEnfant{2}:=<>tl_TBEnfant{2}+1
				End if 
			Else 
				<>te_TBEnfant{1}:=<>te_TBEnfant{1}+1
				If ($TuCompte)
					<>tl_TBEnfant{1}:=<>tl_TBEnfant{1}+1
				End if 
			End if 
		End if 
		
		If (sPersMaj=1)
			$Position:=Find in array:C230(<>ta_MRMpro; [DossierSocial:25]DS_PersonMajeur:24)
			If ($Position>0)
				te_MRMpro{$Position}:=te_MRMpro{$Position}+1
				If ($TuCompte)
					tl_MRMpro{$Position}:=tl_MRMpro{$Position}+1
				End if 
			End if 
		End if 
		
		If (sTpsErr=1)
			$Position:=Find in array:C230(<>ta_TBTpsErr; [DossierSocial:25]DS_TempsErrance:35)
			If ($Position>0)
				te_TBTpsErr{$Position}:=te_TBTpsErr{$Position}+1
				If ($TuCompte)
					tl_TBTpsErr{$Position}:=tl_TBTpsErr{$Position}+1
				End if 
			End if 
		End if 
		
		If (sDerSSP=1)
			$Position:=Find in array:C230(<>ta_MRPssp; [DossierSocial:25]DS_PremièreSSP:40)
			If ($Position>0)
				te_MRPssp{$Position}:=te_MRPssp{$Position}+1
				If ($TuCompte)
					tl_MRPssp{$Position}:=tl_MRPssp{$Position}+1
				End if 
			End if 
		End if 
		
		If (sAss=1)
			$Position:=Find in array:C230(<>ta_InAsSoc; [DossierSocial:25]DS_Assistante:9)
			If ($Position>0)
				te_InAsSoc{$Position}:=te_InAsSoc{$Position}+1
				If ($TuCompte)
					tl_InAsSoc{$Position}:=tl_InAsSoc{$Position}+1
				End if 
			End if 
		End if 
		
		If (sEnCh=1)
			$Position:=Find in array:C230(<>ta_MRPch; [DossierSocial:25]DS_EnChargeEMA:25)
			If ($Position>0)
				te_MRPch{$Position}:=te_MRPch{$Position}+1
				If ($TuCompte)
					tl_MRPch{$Position}:=tl_MRPch{$Position}+1
				End if 
			End if 
		End if 
		
		If (sRefus=1)
			$Position:=Find in array:C230(<>ta_MRrefu; [DossierSocial:25]DS_RefusEMA:26)
			If ($Position>0)
				te_MRrefu{$Position}:=te_MRrefu{$Position}+1
				If ($TuCompte)
					tl_MRrefu{$Position}:=tl_MRrefu{$Position}+1
				End if 
			End if 
		End if 
		
		If (sConn=1)
			$Position:=Find in array:C230(<>ta_MRQui; [DossierSocial:25]DS_Connaissance:36)
			If ($Position>0)
				te_MRQui{$Position}:=te_MRQui{$Position}+1
				If ($TuCompte)
					tl_MRQui{$Position}:=tl_MRQui{$Position}+1
				End if 
			End if 
		End if 
		
		If (sComp=1)
			$Position:=Find in array:C230(<>ta_DScomp; [DossierSocial:25]DS_Compagnie:37)
			If ($Position>0)
				te_DScomp{$Position}:=te_DScomp{$Position}+1
				If ($TuCompte)
					tl_DScomp{$Position}:=tl_DScomp{$Position}+1
				End if 
			End if 
		End if 
		
		If (sPap=1)
			If ([DossierSocial:25]DS_PapiersQuest:47=True:C214)
				<>te_Papier{2}:=<>te_Papier{2}+1
				If ($TuCompte)
					<>tl_Papier{2}:=<>tl_Papier{2}+1
				End if 
			Else 
				<>te_Papier{1}:=<>te_Papier{1}+1
				If ($TuCompte)
					<>tl_Papier{1}:=<>tl_Papier{1}+1
				End if 
			End if 
		End if 
		
		If (sPap_1=1)
			$Position:=Find in array:C230(<>ta_DSidté; [DossierSocial:25]DS_Papier1:48)
			If ($Position>0)
				te_DSidté{$Position}:=te_DSidté{$Position}+1
				If ($TuCompte)
					tl_DSidté{$Position}:=tl_DSidté{$Position}+1
				End if 
			End if 
		End if 
		
		If (sRegime=1)
			If ([DossierSocial:25]DS_RégimeQuest:66=True:C214)
				<>te_Régime{2}:=<>te_Régime{2}+1
				If ($TuCompte)
					<>tl_Régime{2}:=<>tl_Régime{2}+1
				End if 
			Else 
				<>te_Régime{1}:=<>te_Régime{1}+1
				If ($TuCompte)
					<>tl_Régime{1}:=<>tl_Régime{1}+1
				End if 
			End if 
		End if 
		
		If (sRegime_1=1)
			$Position:=Find in array:C230(<>ta_DSrég; [DossierSocial:25]DS_Régime1:67)
			If ($Position>0)
				te_DSrég{$Position}:=te_DSrég{$Position}+1
				If ($TuCompte)
					tl_DSrég{$Position}:=tl_DSrég{$Position}+1
				End if 
			End if 
		End if 
		
		If (sSuivi=1)
			If ([DossierSocial:25]DS_SuiviSQuest:69=True:C214)
				<>te_Suivi{2}:=<>te_Suivi{2}+1
				If ($TuCompte)
					<>tl_Suivi{2}:=<>tl_Suivi{2}+1
				End if 
			Else 
				<>te_Suivi{1}:=<>te_Suivi{1}+1
				If ($TuCompte)
					<>tl_Suivi{1}:=<>tl_Suivi{1}+1
				End if 
			End if 
		End if 
		
		If (sSuivi_1=1)
			$Position:=Find in array:C230(<>ta_DSsuivi; [DossierSocial:25]DS_SuiviS1:70)
			If ($Position>0)
				te_DSsuivi{$Position}:=te_DSsuivi{$Position}+1
				If ($TuCompte)
					tl_DSsuivi{$Position}:=tl_DSsuivi{$Position}+1
				End if 
			End if 
		End if 
		
		If (sCouv=1)
			If ([DossierSocial:25]DS_CouvSocQuest:50=True:C214)
				<>te_Couverture{2}:=<>te_Couverture{2}+1
				If ($TuCompte)
					<>tl_Couverture{2}:=<>tl_Couverture{2}+1
				End if 
			Else 
				<>te_Couverture{1}:=<>te_Couverture{1}+1
				If ($TuCompte)
					<>tl_Couverture{1}:=<>tl_Couverture{1}+1
				End if 
			End if 
		End if 
		
		If (sCouv_1=1)
			$Position:=Find in array:C230(<>ta_DScs; [DossierSocial:25]DS_CouvSoc1_1:51)
			If ($Position>0)
				te_DScs{$Position}:=te_DScs{$Position}+1
				If ($TuCompte)
					tl_DScs{$Position}:=tl_DScs{$Position}+1
				End if 
			End if 
		End if 
		
		
		
		If (sRess=1)
			If ([DossierSocial:25]DS_ResourcQuest:57=True:C214)
				<>te_Ressource{2}:=<>te_Ressource{2}+1
				If ($TuCompte)
					<>tl_Ressource{2}:=<>tl_Ressource{2}+1
				End if 
			Else 
				<>te_Ressource{1}:=<>te_Ressource{1}+1
				If ($TuCompte)
					<>tl_Ressource{1}:=<>tl_Ressource{1}+1
				End if 
			End if 
		End if 
		
		If (sRess_1=1)
			$Position:=Find in array:C230(<>ta_MRrs; [DossierSocial:25]DS_Ressour1_1:58)
			If ($Position>0)
				te_MRrs{$Position}:=te_MRrs{$Position}+1
				If ($TuCompte)
					tl_MRrs{$Position}:=tl_MRrs{$Position}+1
				End if 
			End if 
		End if 
		
		If (sSor=1)
			If ([DossierSocial:25]DS_Sortie:72=True:C214)
				<>te_Sortie{2}:=<>te_Sortie{2}+1
				If ($TuCompte)
					<>tl_Sortie{2}:=<>tl_Sortie{2}+1
				End if 
			Else 
				<>te_Sortie{1}:=<>te_Sortie{1}+1
				If ($TuCompte)
					<>tl_Sortie{1}:=<>tl_Sortie{1}+1
				End if 
			End if 
		End if 
		
		If (sSor_1=1)
			$Position:=Find in array:C230(<>ta_MRSctr; [DossierSocial:25]DS_SortieCtr1:73)
			If ($Position>0)
				te_MRSctr{$Position}:=te_MRSctr{$Position}+1
				If ($TuCompte)
					tl_MRSctr{$Position}:=tl_MRSctr{$Position}+1
				End if 
			End if 
		End if 
		
		NEXT RECORD:C51([DossierSocial:25])
	End while 
	
End if 
