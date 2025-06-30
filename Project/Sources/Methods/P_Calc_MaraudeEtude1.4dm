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
P_Calc_MaraudeEtude2
If (7=8)
	C_LONGINT:C283($vl_Pas; $vl_PasTable)
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
				P_Compter($TuCompte; ->ta_FilexEtCiv; ->te_FileEtCivNb; ->tl_FileEtCivNb; ->[Maraude:24]MR_EtatCivil:16)
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
				P_Compter($TuCompte; -><>ta_TBLieuNé; ->te_TBLieuNé; ->tl_TBLieuNé; ->[Maraude:24]MR_LieuNéOù:21)
			End if 
			If (sSignal=1)
				P_Compter($TuCompte; -><>ta_MRsg; ->te_MRsg; ->tl_MRsg; ->[Maraude:24]MR_Signalt:12)
			End if 
			If (sEmplace=1)
				P_Compter($TuCompte; -><>ta_TBPorte; ->te_TBPorte; ->tl_TBPorte; ->[Maraude:24]MR_Emplacement:14)
			End if 
			If (sCP=1)
				P_Compter($TuCompte; -><>ta_TBArr; ->te_TBArr; ->tl_TBArr; ->[Maraude:24]MR_ArrondCP:15)
			End if 
			If (sDem=1)
				P_Compter($TuCompte; -><>ta_MRDem; ->te_MRDem; ->tl_MRDem; ->[Maraude:24]MR_Demande:24)
			End if 
			If (sQuar=1)
				P_Compter($TuCompte; -><>ta_MRqua; ->te_MRqua; ->tl_MRqua; ->[Maraude:24]MR_Motif:25)
			End if 
			If (sEgene=1)
				P_Compter($TuCompte; -><>ta_MReGé; ->te_MReGé; ->tl_MReGé; ->[Maraude:24]MR_EtatGénéral:26)
			End if 
			If (sEcut=1)
				P_Compter($TuCompte; -><>ta_MReCu; ->te_MReCu; ->tl_MReCu; ->[Maraude:24]MR_EtatCutané:27)
			End if 
			If (sRel=1)
				P_Compter($TuCompte; -><>ta_MRrel; ->te_MRrel; ->tl_MRrel; ->[Maraude:24]MR_Relation:28)
			End if 
			If (sHy=1)
				P_Compter($TuCompte; -><>ta_MRhyg; ->te_MRhyg; ->tl_MRhyg; ->[Maraude:24]MR_Hygiène:81)
			End if 
			If (sHan=1)
				P_Compter($TuCompte; -><>ta_MRhan; ->te_MRhan; ->tl_MRhan; ->[Maraude:24]MR_Handicap:82)
			End if 
			If (sLangue=1)
				P_Compter($TuCompte; -><>ta_Lgs; ->te_Lgs; ->tl_Lgs; ->[Maraude:24]MR_Lange1:29)
			End if 
			If (sORsoc=1)
				P_Compter($TuCompte; -><>ta_OrSc; ->te_OrSc; ->tl_OrSc; ->[Maraude:24]MR_OrSoc:36)
			End if 
			If (sORmed=1)
				P_Compter($TuCompte; -><>ta_OrMd; ->te_OrMd; ->tl_OrMd; ->[Maraude:24]MR_OrMéd:33)
			End if 
			If (sDerHb=1)
				P_Compter($TuCompte; -><>ta_DerLH; ->te_DerLH; ->tl_DerLH; ->[Maraude:24]MR_DernierHéb1:46)
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
				P_Compter($TuCompte; -><>ta_MRQui; ->te_MRQui; ->tl_MRQui; ->[Maraude:24]MR_Connaissance:51)
			End if 
			
			If (sMotif=1)
				P_Compter($TuCompte; -><>ta_MRrefu; ->te_MRrefu; ->tl_MRrefu; ->[Maraude:24]MR_RefusEMA:44)
			End if 
			If (sMode=1)
				P_Compter($TuCompte; -><>ta_Qmod; ->te_Qmod; ->tl_Qmod; ->[Maraude:24]MR_Mode1:48)
			End if 
			If (sTemps=1)
				P_Compter($TuCompte; -><>ta_TBTpsErr; ->te_TBTpsErr; ->tl_TBTpsErr; ->[Maraude:24]MR_TempsErrance:50)
			End if 
			If (sComp=1)
				P_Compter($TuCompte; -><>ta_DScomp; ->te_DScomp; ->tl_DScomp; ->[Maraude:24]MR_Compagnie:52)
			End if 
			If (sCouv=1)
				P_Compter($TuCompte; -><>ta_DScs; ->te_DScs; ->tl_DScs; ->[Maraude:24]MR_CouvSoc1_1:58)
			End if 
			If (sRess=1)
				P_Compter($TuCompte; -><>ta_MRrs; ->te_MRrs; ->tl_MRrs; ->[Maraude:24]MR_Ressour1_1:65)
			End if 
			If (sPap=1)
				P_Compter($TuCompte; -><>ta_DSidté; ->te_DSidté; ->tl_DSidté; ->[Maraude:24]MR_Papier1:55)
			End if 
			If (sRegime=1)
				P_Compter($TuCompte; -><>ta_DSrég; ->te_DSrég; ->tl_DSrég; ->[Maraude:24]MR_Régime1:72)
			End if 
			If (sSuivi=1)
				P_Compter($TuCompte; -><>ta_DSsuivi; ->te_DSsuivi; ->tl_DSsuivi; ->[Maraude:24]MR_SuiviS1:76)
			End if 
			
			NEXT RECORD:C51([Maraude:24])
		End while 
		
	End if 
End if 