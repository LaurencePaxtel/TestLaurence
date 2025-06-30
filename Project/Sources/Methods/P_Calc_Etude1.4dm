//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Etude1
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($ii; $Position; $vl_Pas; $vl_PasTable)
C_BOOLEAN:C305($TuCompte)
// i_MessageSeul ("Calcul en cours …")
If (<>vb_StopEven=False:C215)
	
	V_Stat_Etude(1)
	CREATE EMPTY SET:C140([HeBerge:4]; "E_HBCompte")
	USE SET:C118("E_encours")
	$vl_PasTable:=Records in selection:C76([HeberGement:5])
	$vl_Pas:=0
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
	//FIRST RECORD([HeberGement])
	
	
	//While ((Not(End selection([HeberGement]))) & (<>vb_StopEven=False))
	
	
	ARRAY LONGINT:C221($rL_HG_HB_ID; 0)
	ARRAY BOOLEAN:C223($rB_HG_Genre; 0)
	ARRAY TEXT:C222($rT_HG_EtatCivil; 0)
	ARRAY INTEGER:C220($rI_HG_Age; 0)
	ARRAY LONGINT:C221($rL_HG_AttenteHeur; 0)
	ARRAY LONGINT:C221($rL_HG_ClotureeHeur; 0)
	ARRAY TEXT:C222($rT_HG_Signalement; 0)
	ARRAY TEXT:C222($rT_HG_SituFamille; 0)
	ARRAY TEXT:C222($rT_HG_Nationalité; 0)
	ARRAY BOOLEAN:C223($rB_HG_Médicalise; 0)
	ARRAY TEXT:C222($rT_HG_TempsErrance; 0)
	ARRAY TEXT:C222($rT_HG_Ressources1; 0)
	ARRAY TEXT:C222($rT_HG_SuiviSocial1; 0)
	ARRAY TEXT:C222($rL_HG_CouvSocial1; 0)
	ARRAY TEXT:C222($rT_HG_Orientation1; 0)
	ARRAY TEXT:C222($rT_HG_Orientation2; 0)
	ARRAY TEXT:C222($rT_HG_AutreSolutio; 0)
	ARRAY TEXT:C222($rT_HG_Gare; 0)
	ARRAY TEXT:C222($rT_HG_Métro; 0)
	ARRAY TEXT:C222($rT_HG_RupMajeur1; 0)
	ARRAY TEXT:C222($rT_HG_CodePostal; 0)
	ARRAY TEXT:C222($rT_HG_DernierEmplo; 0)
	ARRAY TEXT:C222($rT_HG_SituProfess; 0)
	ARRAY TEXT:C222($rT_HG_DernierHéber; 0)
	ARRAY TEXT:C222($rT_HG_Lien; 0)
	ARRAY TEXT:C222($rT_HG_PiècesIdte1; 0)
	ARRAY TEXT:C222($rT_HG_NiveauEtude; 0)
	ARRAY TEXT:C222($rT_HG_FamCasSpec; 0)
	
	SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $rL_HG_HB_ID; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Genre:96; $rB_HG_Genre; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_EtatCivil:20; $rT_HG_EtatCivil; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Age:23; $rI_HG_Age; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_AttenteHeur:83; $rL_HG_AttenteHeur; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_CloturéeHeur:86; $rL_HG_ClotureeHeur; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Signalement:12; $rT_HG_Signalement; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_SituFamille:29; $rT_HG_SituFamille; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Nationalité:25; $rT_HG_Nationalité; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Médicalisé:56; $rB_HG_Médicalise; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_TempsErrance:34; $rT_HG_TempsErrance; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Ressources1:45; $rT_HG_Ressources1; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_SuiviSocial1:49; $rT_HG_SuiviSocial1; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_CouvSocial1:53; $rL_HG_CouvSocial1; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Orientation1:58; $rT_HG_Orientation1; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Orientation2:60; $rT_HG_Orientation2; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_AutreSolutio:88; $rT_HG_AutreSolutio; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Gare:15; $rT_HG_Gare; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Métro:16; $rT_HG_Métro; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_RupMajeur1:40; $rT_HG_RupMajeur1; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_CodePostal:14; $rT_HG_CodePostal; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_DernierEmplo:37; $rT_HG_DernierEmplo; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_SituProfess:36; $rT_HG_SituProfess; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_DernierHéber:35; $rT_HG_DernierHéber; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Lien:18; $rT_HG_Lien; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_PiècesIdté1:31; $rT_HG_PiècesIdte1; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_NiveauEtude:43; $rT_HG_NiveauEtude; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamCasSpéc:111; $rT_HG_FamCasSpec)
	
	C_LONGINT:C283($L_Compteur)
	For ($L_Compteur; 1; Records in selection:C76([HeberGement:5]))
		
		//$vl_Pas:=$vl_Pas+1
		//i_MessageSeul ("Calcul en cours  : "+String($vl_PasTable)+" / "+String($vl_Pas))
		
		$TuCompte:=False:C215
		//RELATE ONE([HeberGement]HG_HB_ID)
		
		SET QUERY LIMIT:C395(1)
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$rL_HG_HB_ID{$L_Compteur})
		MultiSoc_Filter(->[HeBerge:4])
		SET QUERY LIMIT:C395(0)
		
		If (Records in selection:C76([HeBerge:4])=1)
			If (Is in set:C273("E_HBCompte"))
			Else 
				ADD TO SET:C119([HeBerge:4]; "E_HBCompte")
				$TuCompte:=True:C214
			End if 
		End if 
		If (sSexe=1)
			
			If ($rB_HG_Genre{$L_Compteur}=True:C214)
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
		//Etat civil
		If (sEtCv=1)
			$Position:=Find in array:C230(ta_FilexEtCiv; $rT_HG_EtatCivil{$L_Compteur})
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
				: ($rI_HG_Age{$L_Compteur}<=<>te_TBAge{1})
					<>te_NbAge{1}:=<>te_NbAge{1}+1
					If ($TuCompte)
						<>tl_NbAge{1}:=<>tl_NbAge{1}+1
					End if 
					//3 -18            
				: ($rI_HG_Age{$L_Compteur}><>te_TBAge{1}) & ($rI_HG_Age{$L_Compteur}<<>te_TBAge{2})
					<>te_NbAge{2}:=<>te_NbAge{2}+1
					If ($TuCompte)
						<>tl_NbAge{2}:=<>tl_NbAge{2}+1
					End if 
					// 19-24
				: ($rI_HG_Age{$L_Compteur}>=<>te_TBAge{2}) & ($rI_HG_Age{$L_Compteur}<=<>te_TBAge{3})
					<>te_NbAge{3}:=<>te_NbAge{3}+1
					If ($TuCompte)
						<>tl_NbAge{3}:=<>tl_NbAge{3}+1
					End if 
					//25-29
				: ($rI_HG_Age{$L_Compteur}><>te_TBAge{3}) & ($rI_HG_Age{$L_Compteur}<=<>te_TBAge{4})
					<>te_NbAge{4}:=<>te_NbAge{4}+1
					If ($TuCompte)
						<>tl_NbAge{4}:=<>tl_NbAge{4}+1
					End if 
					//30-39
				: ($rI_HG_Age{$L_Compteur}><>te_TBAge{4}) & ($rI_HG_Age{$L_Compteur}<=<>te_TBAge{5})
					<>te_NbAge{5}:=<>te_NbAge{5}+1
					If ($TuCompte)
						<>tl_NbAge{5}:=<>tl_NbAge{5}+1
					End if 
					//40-49
				: ($rI_HG_Age{$L_Compteur}><>te_TBAge{5}) & ($rI_HG_Age{$L_Compteur}<=<>te_TBAge{6})
					<>te_NbAge{6}:=<>te_NbAge{6}+1
					If ($TuCompte)
						<>tl_NbAge{6}:=<>tl_NbAge{6}+1
					End if 
					//50-59
				: ($rI_HG_Age{$L_Compteur}><>te_TBAge{6}) & ($rI_HG_Age{$L_Compteur}<=<>te_TBAge{7})
					<>te_NbAge{7}:=<>te_NbAge{7}+1
					If ($TuCompte)
						<>tl_NbAge{7}:=<>tl_NbAge{7}+1
					End if 
					//60-69
				: ($rI_HG_Age{$L_Compteur}><>te_TBAge{7}) & ($rI_HG_Age{$L_Compteur}<=<>te_TBAge{8})
					<>te_NbAge{8}:=<>te_NbAge{8}+1
					If ($TuCompte)
						<>tl_NbAge{8}:=<>tl_NbAge{8}+1
					End if 
					//+70
				: ($rI_HG_Age{$L_Compteur}>=<>te_TBAge{9})
					<>te_NbAge{9}:=<>te_NbAge{9}+1
					If ($TuCompte)
						<>tl_NbAge{9}:=<>tl_NbAge{9}+1
					End if 
			End case 
		End if 
		va_Alfa1:=Time string:C180($rL_HG_AttenteHeur{$L_Compteur})
		<>ts_Hatt{$ii}:=Num:C11(Substring:C12(va_Alfa1; 1; 2))
		va_Alfa1:=Time string:C180($rL_HG_ClotureeHeur{$L_Compteur})
		<>ts_HClo{$ii}:=Num:C11(Substring:C12(va_Alfa1; 1; 2))
		
		If (sHeure=1)
			va_Alfa1:=Time string:C180($rL_HG_AttenteHeur{$L_Compteur})
			ve_Alfa1:=Num:C11(Substring:C12(va_Alfa1; 1; 2))
			$Position:=Find in array:C230(<>ts_Heures; ve_Alfa1)
			If ($Position>0)
				<>te_NbHatt{$Position}:=<>te_NbHatt{$Position}+1
			End if 
			va_Alfa1:=Time string:C180($rL_HG_ClotureeHeur{$L_Compteur})
			ve_Alfa1:=Num:C11(Substring:C12(va_Alfa1; 1; 2))
			$Position:=Find in array:C230(<>ts_Heures; ve_Alfa1)
			If ($Position>0)
				<>te_NbHClo{$Position}:=<>te_NbHClo{$Position}+1
			End if 
		End if 
		If (sSignal=1)
			$Position:=Find in array:C230(<>ta_TBSglt; $rT_HG_Signalement{$L_Compteur})
			If ($Position>0)
				<>te_NbSglt{$Position}:=<>te_NbSglt{$Position}+1
				If ($TuCompte)
					<>tl_NbSglt{$Position}:=<>tl_NbSglt{$Position}+1
				End if 
			End if 
		End if 
		If (sSitFam=1)
			$Position:=Find in array:C230(<>ta_TBSitFam; $rT_HG_SituFamille{$L_Compteur})
			If ($Position>0)
				<>te_NbSitF{$Position}:=<>te_NbSitF{$Position}+1
				If ($TuCompte)
					<>tl_NbSitF{$Position}:=<>tl_NbSitF{$Position}+1
				End if 
			End if 
		End if 
		If (sNation=1)
			$Position:=Find in array:C230(<>ta_TBNatio; $rT_HG_Nationalité{$L_Compteur})
			If ($Position>0)
				<>te_NbNatio{$Position}:=<>te_NbNatio{$Position}+1
				If ($TuCompte)
					<>tl_NbNatio{$Position}:=<>tl_NbNatio{$Position}+1
				End if 
			End if 
		End if 
		If (sMéd=1)
			If ($rB_HG_Médicalise{$L_Compteur}=False:C215)
				<>te_NbMéd{1}:=<>te_NbMéd{1}+1
				If ($TuCompte)
					<>tl_NbMéd{1}:=<>tl_NbMéd{1}+1
				End if 
			Else 
				<>te_NbMéd{2}:=<>te_NbMéd{2}+1
				If ($TuCompte)
					<>tl_NbMéd{2}:=<>tl_NbMéd{2}+1
				End if 
			End if 
		End if 
		If (sErrance=1)
			$Position:=Find in array:C230(<>ta_TBTpsErr; $rT_HG_TempsErrance{$L_Compteur})
			If ($Position>0)
				<>te_NbErr{$Position}:=<>te_NbErr{$Position}+1
				If ($TuCompte)
					<>tl_NbErr{$Position}:=<>tl_NbErr{$Position}+1
				End if 
			End if 
		End if 
		If (sRess=1)
			$Position:=Find in array:C230(<>ta_TBResAct; $rT_HG_Ressources1{$L_Compteur})
			If ($Position>0)
				<>te_NbRes{$Position}:=<>te_NbRes{$Position}+1
				If ($TuCompte)
					<>tl_NbRes{$Position}:=<>tl_NbRes{$Position}+1
				End if 
			End if 
		End if 
		If (sSuivi=1)
			$Position:=Find in array:C230(<>ta_TBSuiSoc; $rT_HG_SuiviSocial1{$L_Compteur})
			If ($Position>0)
				<>te_NbSui{$Position}:=<>te_NbSui{$Position}+1
				If ($TuCompte)
					<>tl_NbSui{$Position}:=<>tl_NbSui{$Position}+1
				End if 
			End if 
		End if 
		If (sCouv=1)
			$Position:=Find in array:C230(<>ta_TBCouSoc; $rL_HG_CouvSocial1{$L_Compteur})
			If ($Position>0)
				<>te_NbCou{$Position}:=<>te_NbCou{$Position}+1
				If ($TuCompte)
					<>tl_NbCou{$Position}:=<>tl_NbCou{$Position}+1
				End if 
			End if 
		End if 
		If (sOR1=1)
			$Position:=Find in array:C230(<>ta_TBOr1; $rT_HG_Orientation1{$L_Compteur})
			If ($Position>0)
				<>te_NbOr1{$Position}:=<>te_NbOr1{$Position}+1
				If ($TuCompte)
					<>tl_NbOr1{$Position}:=<>tl_NbOr1{$Position}+1
				End if 
			End if 
		End if 
		If (sOR2=1)
			$Position:=Find in array:C230(<>ta_TBOr2; $rT_HG_Orientation2{$L_Compteur})
			If ($Position>0)
				<>te_NbOr2{$Position}:=<>te_NbOr2{$Position}+1
				If ($TuCompte)
					<>tl_NbOr2{$Position}:=<>tl_NbOr2{$Position}+1
				End if 
			End if 
		End if 
		If (sAutre=1)
			$Position:=Find in array:C230(<>ta_AtS; $rT_HG_AutreSolutio{$L_Compteur})
			If ($Position>0)
				<>te_NbAtS{$Position}:=<>te_NbAtS{$Position}+1
				If ($TuCompte)
					<>tl_NbAtS{$Position}:=<>tl_NbAtS{$Position}+1
				End if 
			End if 
		End if 
		If (sGare=1)
			$Position:=Find in array:C230(<>ta_TBGare; $rT_HG_Gare{$L_Compteur})
			If ($Position>0)
				<>te_NbGare{$Position}:=<>te_NbGare{$Position}+1
				If ($TuCompte)
					<>tl_NbGare{$Position}:=<>tl_NbGare{$Position}+1
				End if 
			End if 
		End if 
		If (sVille=1)
			$Position:=Find in array:C230(<>ta_TBMetro; $rT_HG_Métro{$L_Compteur})
			If ($Position>0)
				<>te_NbMetro{$Position}:=<>te_NbMetro{$Position}+1
				If ($TuCompte)
					<>tl_NbMetro{$Position}:=<>tl_NbMetro{$Position}+1
				End if 
			End if 
		End if 
		If (sRupt=1)
			$Position:=Find in array:C230(<>ta_TBRupMaj; $rT_HG_RupMajeur1{$L_Compteur})
			If ($Position>0)
				<>te_TBRupMaj{$Position}:=<>te_TBRupMaj{$Position}+1
				If ($TuCompte)
					<>tl_TBRupMajo{$Position}:=<>tl_TBRupMajo{$Position}+1
				End if 
			End if 
		End if 
		If (sCP=1)
			$Position:=Find in array:C230(<>ta_TBArr; $rT_HG_CodePostal{$L_Compteur})
			If ($Position>0)
				<>te_NbArr{$Position}:=<>te_NbArr{$Position}+1
				If ($TuCompte)
					<>tl_NbArr{$Position}:=<>tl_NbArr{$Position}+1
				End if 
			End if 
		End if 
		If (sDerJob=1)
			$Position:=Find in array:C230(<>ta_TBDerJob; $rT_HG_DernierEmplo{$L_Compteur})
			If ($Position>0)
				<>te_TBDerJob{$Position}:=<>te_TBDerJob{$Position}+1
				If ($TuCompte)
					<>tl_TBDerJob{$Position}:=<>tl_TBDerJob{$Position}+1
				End if 
			End if 
		End if 
		If (sSitPro=1)
			$Position:=Find in array:C230(<>ta_TBSitPro; $rT_HG_SituProfess{$L_Compteur})
			If ($Position>0)
				<>te_TBSitPro{$Position}:=<>te_TBSitPro{$Position}+1
				If ($TuCompte)
					<>tl_TBSitPro{$Position}:=<>tl_TBSitPro{$Position}+1
				End if 
			End if 
		End if 
		If (sDerHg=1)
			$Position:=Find in array:C230(<>ta_TBDerHéb; $rT_HG_DernierHéber{$L_Compteur})
			If ($Position>0)
				<>te_TBDerHéb{$Position}:=<>te_TBDerHéb{$Position}+1
				If ($TuCompte)
					<>tl_TBDerHéb{$Position}:=<>tl_TBDerHéb{$Position}+1
				End if 
			End if 
		End if 
		If (sLien=1)
			$Position:=Find in array:C230(<>ta_TBLien; $rT_HG_Lien{$L_Compteur})
			If ($Position>0)
				<>te_TBLien{$Position}:=<>te_TBLien{$Position}+1
				If ($TuCompte)
					<>tl_TBLien{$Position}:=<>tl_TBLien{$Position}+1
				End if 
			End if 
		End if 
		If (sPIdté=1)
			$Position:=Find in array:C230(<>ta_TBPIdté; $rT_HG_PiècesIdte1{$L_Compteur})
			If ($Position>0)
				<>te_TBPIdté{$Position}:=<>te_TBPIdté{$Position}+1
				If ($TuCompte)
					<>tl_TBPIdté{$Position}:=<>tl_TBPIdté{$Position}+1
				End if 
			End if 
		End if 
		If (sNivEtude=1)
			$Position:=Find in array:C230(<>ta_TBNivEtu; $rT_HG_NiveauEtude{$L_Compteur})
			If ($Position>0)
				<>te_TBNivEtu{$Position}:=<>te_TBNivEtu{$Position}+1
				If ($TuCompte)
					<>tl_TBNivEtu{$Position}:=<>tl_TBNivEtu{$Position}+1
				End if 
			End if 
		End if 
		If (sCasSpec=1)
			$Position:=Find in array:C230(<>ta_FMCaS; $rT_HG_FamCasSpec{$L_Compteur})
			If ($Position>0)
				<>te_FMCaS{$Position}:=<>te_FMCaS{$Position}+1
				If ($TuCompte)
					<>tl_FMCaS{$Position}:=<>tl_FMCaS{$Position}+1
				End if 
			End if 
		End if 
		
		// NEXT RECORD([HeberGement])
	End for 
End if 