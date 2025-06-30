//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_MaraudeEtude1
//{P_Calc_MaraudeEtude2
//{          Mardi 10 mai 2005 à 12:19:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($Position; $vl_Pas; $vl_PasTable)
C_BOOLEAN:C305($TuCompte)


i_MessageSeul("Calcul en cours …")
If (<>vb_StopEven=False:C215)
	//remise à zero de valeurs
	V_Stat_MaraudeEt(1; 0)
	
	CREATE EMPTY SET:C140([HeBerge:4]; "E_HBCompte")
	USE SET:C118("E_encours")
	$vl_PasTable:=Records in selection:C76([Maraude:24])
	$vl_Pas:=0
	
	ORDER BY:C49([Maraude:24]; [Maraude:24]MR_Date:4; <)
	FIRST RECORD:C50([Maraude:24])
	
	While ((Not:C34(End selection:C36([Maraude:24]))) & (<>vb_StopEven=False:C215))
		$vl_Pas:=$vl_Pas+1
		i_MessageSeul("Calcul en cours  : "+String:C10($vl_PasTable)+" / "+String:C10($vl_Pas))
		
		$TuCompte:=False:C215
		
		RELATE ONE:C42([Maraude:24]MR_HB_ID:10)
		If (Records in selection:C76([HeBerge:4])=1)
			If (Is in set:C273("E_HBCompte"))
			Else 
				ADD TO SET:C119([HeBerge:4]; "E_HBCompte")
				$TuCompte:=True:C214
			End if 
		End if 
		
		If (sSexe=1)
			If ([Maraude:24]MR_Genre:42=True:C214)
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
			$Position:=Find in array:C230(ta_FilexEtCiv; [Maraude:24]MR_EtatCivil:16)
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
				: ([Maraude:24]MR_Age:19<=<>te_TBAge{1})
					<>te_NbAge{1}:=<>te_NbAge{1}+1
					If ($TuCompte)
						<>tl_NbAge{1}:=<>tl_NbAge{1}+1
					End if 
					//3 -18            
				: ([Maraude:24]MR_Age:19><>te_TBAge{1}) & ([Maraude:24]MR_Age:19<<>te_TBAge{2})
					<>te_NbAge{2}:=<>te_NbAge{2}+1
					If ($TuCompte)
						<>tl_NbAge{2}:=<>tl_NbAge{2}+1
					End if 
					// 19-24
				: ([Maraude:24]MR_Age:19>=<>te_TBAge{2}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{3})
					<>te_NbAge{3}:=<>te_NbAge{3}+1
					If ($TuCompte)
						<>tl_NbAge{3}:=<>tl_NbAge{3}+1
					End if 
					//25-29
				: ([Maraude:24]MR_Age:19><>te_TBAge{3}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{4})
					<>te_NbAge{4}:=<>te_NbAge{4}+1
					If ($TuCompte)
						<>tl_NbAge{4}:=<>tl_NbAge{4}+1
					End if 
					//30-39
				: ([Maraude:24]MR_Age:19><>te_TBAge{4}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{5})
					<>te_NbAge{5}:=<>te_NbAge{5}+1
					If ($TuCompte)
						<>tl_NbAge{5}:=<>tl_NbAge{5}+1
					End if 
					//40-49
				: ([Maraude:24]MR_Age:19><>te_TBAge{5}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{6})
					<>te_NbAge{6}:=<>te_NbAge{6}+1
					If ($TuCompte)
						<>tl_NbAge{6}:=<>tl_NbAge{6}+1
					End if 
					//50-59
				: ([Maraude:24]MR_Age:19><>te_TBAge{6}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{7})
					<>te_NbAge{7}:=<>te_NbAge{7}+1
					If ($TuCompte)
						<>tl_NbAge{7}:=<>tl_NbAge{7}+1
					End if 
					//60-69
				: ([Maraude:24]MR_Age:19><>te_TBAge{7}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{8})
					<>te_NbAge{8}:=<>te_NbAge{8}+1
					If ($TuCompte)
						<>tl_NbAge{8}:=<>tl_NbAge{8}+1
					End if 
					//+70
				: ([Maraude:24]MR_Age:19>=<>te_TBAge{9})
					<>te_NbAge{9}:=<>te_NbAge{9}+1
					If ($TuCompte)
						<>tl_NbAge{9}:=<>tl_NbAge{9}+1
					End if 
			End case 
		End if 
		
		
		If (sNeOu=1)
			$Position:=Find in array:C230(<>ta_TBLieuNé; [Maraude:24]MR_LieuNéOù:21)
			If ($Position>0)
				te_TBLieuNé{$Position}:=te_TBLieuNé{$Position}+1
				If ($TuCompte)
					tl_TBLieuNé{$Position}:=tl_TBLieuNé{$Position}+1
				End if 
			End if 
		End if 
		
		If (sSignal=1)
			$Position:=Find in array:C230(<>ta_MRsg; [Maraude:24]MR_Signalt:12)
			If ($Position>0)
				te_MRsg{$Position}:=te_MRsg{$Position}+1
				If ($TuCompte)
					tl_MRsg{$Position}:=tl_MRsg{$Position}+1
				End if 
			End if 
		End if 
		
		If (sEmplace=1)
			$Position:=Find in array:C230(<>ta_TBPorte; [Maraude:24]MR_Emplacement:14)
			If ($Position>0)
				te_TBPorte{$Position}:=te_TBPorte{$Position}+1
				If ($TuCompte)
					tl_TBPorte{$Position}:=tl_TBPorte{$Position}+1
				End if 
			End if 
		End if 
		If (sCP=1)
			$Position:=Find in array:C230(<>ta_TBArr; [Maraude:24]MR_ArrondCP:15)
			If ($Position>0)
				te_TBArr{$Position}:=te_TBArr{$Position}+1
				If ($TuCompte)
					tl_TBArr{$Position}:=tl_TBArr{$Position}+1
				End if 
			End if 
		End if 
		If (sDem=1)
			$Position:=Find in array:C230(<>ta_MRDem; [Maraude:24]MR_Demande:24)
			If ($Position>0)
				te_MRDem{$Position}:=te_MRDem{$Position}+1
				If ($TuCompte)
					tl_MRDem{$Position}:=tl_MRDem{$Position}+1
				End if 
			End if 
		End if 
		If (sQuar=1)
			$Position:=Find in array:C230(<>ta_MRqua; [Maraude:24]MR_Motif:25)
			If ($Position>0)
				te_MRqua{$Position}:=te_MRqua{$Position}+1
				If ($TuCompte)
					tl_MRqua{$Position}:=tl_MRqua{$Position}+1
				End if 
			End if 
		End if 
		If (sEgene=1)
			$Position:=Find in array:C230(<>ta_MReGé; [Maraude:24]MR_EtatGénéral:26)
			If ($Position>0)
				te_MReGé{$Position}:=te_MReGé{$Position}+1
				If ($TuCompte)
					tl_MReGé{$Position}:=tl_MReGé{$Position}+1
				End if 
			End if 
		End if 
		If (sEcut=1)
			$Position:=Find in array:C230(<>ta_MReCu; [Maraude:24]MR_EtatCutané:27)
			If ($Position>0)
				te_MReCu{$Position}:=te_MReCu{$Position}+1
				If ($TuCompte)
					tl_MReCu{$Position}:=tl_MReCu{$Position}+1
				End if 
			End if 
		End if 
		If (sRel=1)
			$Position:=Find in array:C230(<>ta_MRrel; [Maraude:24]MR_Relation:28)
			If ($Position>0)
				te_MRrel{$Position}:=te_MRrel{$Position}+1
				If ($TuCompte)
					tl_MRrel{$Position}:=tl_MRrel{$Position}+1
				End if 
			End if 
		End if 
		If (sHy=1)
			$Position:=Find in array:C230(<>ta_MRhyg; [Maraude:24]MR_Hygiène:81)
			If ($Position>0)
				te_MRhyg{$Position}:=te_MRhyg{$Position}+1
				If ($TuCompte)
					tl_MRhyg{$Position}:=tl_MRhyg{$Position}+1
				End if 
			End if 
		End if 
		If (sHan=1)
			$Position:=Find in array:C230(<>ta_MRhan; [Maraude:24]MR_Handicap:82)
			If ($Position>0)
				te_MRhan{$Position}:=te_MRhan{$Position}+1
				If ($TuCompte)
					tl_MRhan{$Position}:=tl_MRhan{$Position}+1
				End if 
			End if 
		End if 
		If (sLangue=1)
			$Position:=Find in array:C230(<>ta_Lgs; [Maraude:24]MR_Lange1:29)
			If ($Position>0)
				te_Lgs{$Position}:=te_Lgs{$Position}+1
				If ($TuCompte)
					tl_Lgs{$Position}:=tl_Lgs{$Position}+1
				End if 
			End if 
		End if 
		If (sORsoc=1)
			$Position:=Find in array:C230(<>ta_OrSc; [Maraude:24]MR_OrSoc:36)
			If ($Position>0)
				te_OrSc{$Position}:=te_OrSc{$Position}+1
				If ($TuCompte)
					tl_OrSc{$Position}:=tl_OrSc{$Position}+1
				End if 
			End if 
		End if 
		If (sORmed=1)
			$Position:=Find in array:C230(<>ta_OrMd; [Maraude:24]MR_OrMéd:33)
			If ($Position>0)
				te_OrMd{$Position}:=te_OrMd{$Position}+1
				If ($TuCompte)
					tl_OrMd{$Position}:=tl_OrMd{$Position}+1
				End if 
			End if 
		End if 
		If (sDerHb=1)
			$Position:=Find in array:C230(<>ta_DerLH; [Maraude:24]MR_DernierHéb1:46)
			If ($Position>0)
				te_DerLH{$Position}:=te_DerLH{$Position}+1
				If ($TuCompte)
					tl_DerLH{$Position}:=tl_DerLH{$Position}+1
				End if 
			End if 
		End if 
		
		If (sDemHb=1)
			If ([Maraude:24]MR_DemHB:80=True:C214)
				<>te_MRdemHb{2}:=<>te_MRdemHb{2}+1
				If ($TuCompte)
					<>tl_MRdemHb{2}:=<>tl_MRdemHb{2}+1
				End if 
			Else 
				<>te_MRdemHb{1}:=<>te_MRdemHb{1}+1
				If ($TuCompte)
					<>tl_MRdemHb{1}:=<>tl_MRdemHb{1}+1
				End if 
			End if 
		End if 
		
		
		If (sPers=1)
			$Position:=Find in array:C230(<>ta_MRQui; [Maraude:24]MR_Connaissance:51)
			If ($Position>0)
				te_MRQui{$Position}:=te_MRQui{$Position}+1
				If ($TuCompte)
					tl_MRQui{$Position}:=tl_MRQui{$Position}+1
				End if 
			End if 
		End if 
		
		If (sMotif=1)
			$Position:=Find in array:C230(<>ta_MRrefu; [Maraude:24]MR_RefusEMA:44)
			If ($Position>0)
				te_MRrefu{$Position}:=te_MRrefu{$Position}+1
				If ($TuCompte)
					tl_MRrefu{$Position}:=tl_MRrefu{$Position}+1
				End if 
			End if 
		End if 
		If (sMode=1)
			$Position:=Find in array:C230(<>ta_Qmod; [Maraude:24]MR_Mode1:48)
			If ($Position>0)
				te_Qmod{$Position}:=te_Qmod{$Position}+1
				If ($TuCompte)
					tl_Qmod{$Position}:=tl_Qmod{$Position}+1
				End if 
			End if 
		End if 
		If (sTemps=1)
			$Position:=Find in array:C230(<>ta_TBTpsErr; [Maraude:24]MR_TempsErrance:50)
			If ($Position>0)
				te_TBTpsErr{$Position}:=te_TBTpsErr{$Position}+1
				If ($TuCompte)
					tl_TBTpsErr{$Position}:=tl_TBTpsErr{$Position}+1
				End if 
			End if 
		End if 
		If (sComp=1)
			$Position:=Find in array:C230(<>ta_DScomp; [Maraude:24]MR_Compagnie:52)
			If ($Position>0)
				te_DScomp{$Position}:=te_DScomp{$Position}+1
				If ($TuCompte)
					tl_DScomp{$Position}:=tl_DScomp{$Position}+1
				End if 
			End if 
		End if 
		If (sCouv=1)
			$Position:=Find in array:C230(<>ta_DScs; [Maraude:24]MR_CouvSoc1_1:58)
			If ($Position>0)
				te_DScs{$Position}:=te_DScs{$Position}+1
				If ($TuCompte)
					tl_DScs{$Position}:=tl_DScs{$Position}+1
				End if 
			End if 
		End if 
		If (sRess=1)
			$Position:=Find in array:C230(<>ta_MRrs; [Maraude:24]MR_Ressour1_1:65)
			If ($Position>0)
				te_MRrs{$Position}:=te_MRrs{$Position}+1
				If ($TuCompte)
					tl_MRrs{$Position}:=tl_MRrs{$Position}+1
				End if 
			End if 
		End if 
		If (sPap=1)
			$Position:=Find in array:C230(<>ta_DSidté; [Maraude:24]MR_Papier1:55)
			If ($Position>0)
				te_DSidté{$Position}:=te_DSidté{$Position}+1
				If ($TuCompte)
					tl_DSidté{$Position}:=tl_DSidté{$Position}+1
				End if 
			End if 
		End if 
		If (sRegime=1)
			$Position:=Find in array:C230(<>ta_DSrég; [Maraude:24]MR_Régime1:72)
			If ($Position>0)
				te_DSrég{$Position}:=te_DSrég{$Position}+1
				If ($TuCompte)
					tl_DSrég{$Position}:=tl_DSrég{$Position}+1
				End if 
			End if 
		End if 
		If (sSuivi=1)
			$Position:=Find in array:C230(<>ta_DSsuivi; [Maraude:24]MR_SuiviS1:76)
			If ($Position>0)
				te_DSsuivi{$Position}:=te_DSsuivi{$Position}+1
				If ($TuCompte)
					tl_DSsuivi{$Position}:=tl_DSsuivi{$Position}+1
				End if 
			End if 
		End if 
		
		NEXT RECORD:C51([Maraude:24])
	End while 
	
End if 