//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ItemCorrection2
//{
//{          Mardi 29 décembre 2009 à 12:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1=0)
		
		C_LONGINT:C283(vl_ItemNuméro2)
		
		//TABLEAU ALPHA(45;◊ta_ItemEum;0)
		
		//TABLEAU ENTIER LONG(◊tl_ItemOldRéf;0)
		//TABLEAU DATE(◊td_ItemOldDate;0)
		//TABLEAU ALPHA(80;◊tt_ItemOld;0)
		
		
		ARRAY TEXT:C222(ta_ItemEum2; 0)
		
		ARRAY LONGINT:C221(tl_ItemOldRéf2; 0)
		ARRAY DATE:C224(td_ItemOldDate2; 0)
		ARRAY TEXT:C222(tt_ItemOld2; 0)
		
		
		
		C_TEXT:C284(va_ItemValeur2)
		C_TEXT:C284(va_Item2; va_ItemTitre2)
		C_TEXT:C284(va_ItemChamp2)
		va_Item2:=""
		va_ItemTitre2:=""
		va_ItemValeur2:=""
		va_ItemChamp2:=""
		ARRAY TEXT:C222(ta_ItemRub2; 39)
		ARRAY POINTER:C280(tp_ItemRub2; 39)
		
		
		ta_ItemRub2{1}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{40}  //"Etat Civil"
		tp_ItemRub2{1}:=->[HeberGement:5]HG_EtatCivil:20
		
		ta_ItemRub2{2}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}  //"Signalement"
		tp_ItemRub2{2}:=->[HeberGement:5]HG_Signalement:12
		
		ta_ItemRub2{3}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{6}  //"Signalement suite"
		tp_ItemRub2{3}:=->[HeberGement:5]HG_SignalCentre:13
		
		ta_ItemRub2{4}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7}  //"Code Postal"
		tp_ItemRub2{4}:=->[HeberGement:5]HG_CodePostal:14
		
		ta_ItemRub2{5}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{8}  //"Gare"
		tp_ItemRub2{5}:=->[HeberGement:5]HG_Gare:15
		
		ta_ItemRub2{6}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9}  //"Métro"
		tp_ItemRub2{6}:=->[HeberGement:5]HG_Métro:16
		
		ta_ItemRub2{7}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{10}  //"Emplacement"
		tp_ItemRub2{7}:=->[HeberGement:5]HG_Emplacement:17
		
		ta_ItemRub2{8}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{11}  //"Lien de parenté"
		tp_ItemRub2{8}:=->[HeberGement:5]HG_Lien:18
		
		ta_ItemRub2{9}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12}  //"Nationalité"
		tp_ItemRub2{9}:=->[HeberGement:5]HG_Nationalité:25
		
		ta_ItemRub2{10}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{13}  //"Situation de Famille"
		tp_ItemRub2{10}:=->[HeberGement:5]HG_SituFamille:29
		
		ta_ItemRub2{11}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{14}  //"Temps d'errance"
		tp_ItemRub2{11}:=->[HeberGement:5]HG_TempsErrance:34
		
		ta_ItemRub2{12}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{15}  //"Dernier hébergement"
		tp_ItemRub2{12}:=->[HeberGement:5]HG_DernierHéber:35
		
		ta_ItemRub2{13}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{16}  //"Situation professionnelle"
		tp_ItemRub2{13}:=->[HeberGement:5]HG_SituProfess:36
		
		ta_ItemRub2{14}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{17}  //"Dernier emploi"
		tp_ItemRub2{14}:=->[HeberGement:5]HG_DernierEmplo:37
		
		ta_ItemRub2{15}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{18}  //"Duré sans emploi"
		tp_ItemRub2{15}:=->[HeberGement:5]HG_DuréSanEmplo:38
		
		ta_ItemRub2{16}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25}  //"Pièces Idté 1"
		tp_ItemRub2{16}:=->[HeberGement:5]HG_PiècesIdté1:31
		
		ta_ItemRub2{17}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{26}  //"Pièces Idté 2"
		tp_ItemRub2{17}:=->[HeberGement:5]HG_PiècesIdté2:32
		
		ta_ItemRub2{18}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{27}  //"Pièces Idté 3"
		tp_ItemRub2{18}:=->[HeberGement:5]HG_PiècesIdté3:33
		
		
		ta_ItemRub2{19}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28}  //"Rupture majeure 1"
		tp_ItemRub2{19}:=->[HeberGement:5]HG_RupMajeur1:40
		
		ta_ItemRub2{20}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{29}  //"Rupture majeure 2"
		tp_ItemRub2{20}:=->[HeberGement:5]HG_RupMajeur2:41
		
		ta_ItemRub2{21}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{30}  //"Rupture majeure 3"
		tp_ItemRub2{21}:=->[HeberGement:5]HG_RupMajeur3:42
		
		ta_ItemRub2{22}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{31}  //"Ressources 1"
		tp_ItemRub2{22}:=->[HeberGement:5]HG_Ressources1:45
		
		ta_ItemRub2{23}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{32}  //"Ressources 2"
		tp_ItemRub2{23}:=->[HeberGement:5]HG_Ressources2:46
		
		ta_ItemRub2{24}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{33}  //"Ressources 3"
		tp_ItemRub2{24}:=->[HeberGement:5]HG_Ressources3:47
		
		
		ta_ItemRub2{25}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{34}  //"Suivi social 1"
		tp_ItemRub2{25}:=->[HeberGement:5]HG_SuiviSocial1:49
		
		ta_ItemRub2{26}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{35}  //"Suivi social 2"
		tp_ItemRub2{26}:=->[HeberGement:5]HG_SuiviSocial2:50
		
		ta_ItemRub2{27}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{36}  //"Suivi social 3"
		tp_ItemRub2{27}:=->[HeberGement:5]HG_SuiviSocial3:51
		
		
		ta_ItemRub2{28}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{37}  //"Couverture sociale 1"
		tp_ItemRub2{28}:=->[HeberGement:5]HG_CouvSocial1:53
		
		ta_ItemRub2{29}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{38}  //"Couverture sociale 2"
		tp_ItemRub2{29}:=->[HeberGement:5]HG_CouvSocial2:54
		
		ta_ItemRub2{30}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{39}  //"Couverture sociale 3"
		tp_ItemRub2{30}:=->[HeberGement:5]HG_CouvSocial3:55
		
		
		ta_ItemRub2{31}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{41}  //"Niveau d'étude"
		tp_ItemRub2{31}:=->[HeberGement:5]HG_NiveauEtude:43
		
		
		
		ta_ItemRub2{32}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{48}  //"Orientation 1"
		tp_ItemRub2{32}:=->[HeberGement:5]HG_Orientation1:58
		
		ta_ItemRub2{33}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{49}  //"Orientation 2"
		tp_ItemRub2{33}:=->[HeberGement:5]HG_Orientation2:60
		
		ta_ItemRub2{34}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}  //"Autre solution"
		tp_ItemRub2{34}:=->[HeberGement:5]HG_AutreSolutio:88
		
		
		ta_ItemRub2{35}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}  //"Famille groupe"
		tp_ItemRub2{35}:=->[HeberGement:5]HG_FamGroupe:102
		
		ta_ItemRub2{36}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{64}  //"Famille clé"
		tp_ItemRub2{36}:=->[HeberGement:5]HG_FamClé:104
		
		
		ta_ItemRub2{37}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{83}  //"FamCas Spec"
		tp_ItemRub2{37}:=->[HeberGement:5]HG_FamCasSpéc:111
		
		ta_ItemRub2{38}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{100}  //"Plateforme"
		tp_ItemRub2{38}:=->[HeberGement:5]HG_Plateforme:139
		
		
		ta_ItemRub2{39}:="Centre"  //"LC_ID""
		tp_ItemRub2{39}:=->[HeberGement:5]HG_LC_ID:61
		
		
		
		ta_ItemRub2:=22  //Ressources
		ve_PosRub:=22  //Ressources
		
		
		ta_ItemRub2:=Size of array:C274(ta_ItemRub2)  //Centre
		ve_PosRub:=ta_ItemRub2  //Centre
		
		
		vl_ItemNuméro2:=2
		va_Item2:=""
		va_ItemTitre2:=ta_ItemRub2{ta_ItemRub2}
		
		P_ItemCorrection2(1)
		
	: ($1=1)
		$vb_OK:=(Size of array:C274(ta_ItemRub2)>0)
		If ($vb_OK)
			$vb_OK:=(ta_ItemRub2>0)
			vl_ItemNuméro2:=ta_ItemRub2
			va_ItemTitre2:=ta_ItemRub2{ta_ItemRub2}
		End if 
		
		If ($vb_OK)
			$vb_OK:=False:C215
			Case of 
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_EtatCivil:20))  //"Etat Civil"
					COPY ARRAY:C226(<>ta_TBEtCiv; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Signalement:12))  //"Signalement"
					COPY ARRAY:C226(<>ta_TBSglt; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_SignalCentre:13))  //"Signalement suite"
					$vb_OK:=True:C214
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_CodePostal:14))  //"Code Postal"
					COPY ARRAY:C226(<>ta_TBArr; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Gare:15))  //"Gare"
					COPY ARRAY:C226(<>ta_TBGare; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Métro:16))  //"Métro"
					COPY ARRAY:C226(<>ta_TBMetro; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Emplacement:17))  //"Emplacement"
					COPY ARRAY:C226(<>ta_TBPorte; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Lien:18))  //"Lien de parenté"
					COPY ARRAY:C226(<>ta_TBLien; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Nationalité:25))  //"Nationalité"
					COPY ARRAY:C226(<>ta_TBNatio; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_SituFamille:29))  //"Situation de Famille"
					COPY ARRAY:C226(<>ta_TBSitFam; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_TempsErrance:34))  //"Temps d'errance"
					COPY ARRAY:C226(<>ta_TBTpsErr; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_DernierHéber:35))  //"Dernier hébergement"
					COPY ARRAY:C226(<>ta_TBDerHéb; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_SituProfess:36))  //"Situation professionnelle"
					COPY ARRAY:C226(<>ta_TBSitPro; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_DernierEmplo:37))  //"Dernier emploi"
					COPY ARRAY:C226(<>ta_TBDerJob; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_DuréSanEmplo:38))  //"Duré sans emploi"
					COPY ARRAY:C226(<>ta_TBDurJob; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_PiècesIdté1:31))  //"Pièces Idté 1"
					COPY ARRAY:C226(<>ta_TBPIdté; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_PiècesIdté2:32))  //"Pièces Idté 2"
					COPY ARRAY:C226(<>ta_TBPIdté2; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_PiècesIdté3:33))  //"Pièces Idté 3"
					COPY ARRAY:C226(<>ta_TBPIdté3; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_RupMajeur1:40))  //"Rupture majeure 1"
					COPY ARRAY:C226(<>ta_TBRupMaj; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_RupMajeur2:41))  //"Rupture majeure 2"
					COPY ARRAY:C226(<>ta_TBRupMaj2; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_RupMajeur3:42))  //"Rupture majeure 3"
					COPY ARRAY:C226(<>ta_TBRupMaj3; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Ressources1:45))  //"Ressources 1"
					COPY ARRAY:C226(<>ta_TBResAct; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Ressources2:46))  //"Ressources 2"
					COPY ARRAY:C226(<>ta_TBResAct2; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Ressources3:47))  //"Ressources 3"
					COPY ARRAY:C226(<>ta_TBResAct3; ta_ItemEum2)
					
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_SuiviSocial1:49))  //"Suivi social 1"
					COPY ARRAY:C226(<>ta_TBSuiSoc; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_SuiviSocial2:50))  //"Suivi social 2"
					COPY ARRAY:C226(<>ta_TBSuiSoc2; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_SuiviSocial3:51))  //"Suivi social 3"
					COPY ARRAY:C226(<>ta_TBSuiSoc3; ta_ItemEum2)
					
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_CouvSocial1:53))  //"Couverture sociale 1"
					COPY ARRAY:C226(<>ta_TBCouSoc; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_CouvSocial2:54))  //"Couverture sociale 2"
					COPY ARRAY:C226(<>ta_TBCouSoc2; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_CouvSocial3:55))  //"Couverture sociale 3"
					COPY ARRAY:C226(<>ta_TBCouSoc3; ta_ItemEum2)
					
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_NiveauEtude:43))  //"Niveau d'étude"
					COPY ARRAY:C226(<>ta_TBNivEtu; ta_ItemEum2)
					
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Orientation1:58))  //"Orientation 1"
					COPY ARRAY:C226(<>ta_TBOr1; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Orientation2:60))  //"Orientation 2"
					COPY ARRAY:C226(<>ta_TBOr2; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_AutreSolutio:88))  //"Autre solution"
					COPY ARRAY:C226(<>ta_AtS; ta_ItemEum2)
					
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_FamGroupe:102))  //"Famille groupe"
					
					COPY ARRAY:C226(<>ta_FMGrpCHRS; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_FamClé:104))  //"Famille clé"
					$vb_OK:=True:C214
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_FamCasSpéc:111))  //"Famille Cas Spéc"
					COPY ARRAY:C226(<>ta_FMCaS; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_Plateforme:139))  //"Plateforme"
					COPY ARRAY:C226(<>ta_Plateforme; ta_ItemEum2)
					
				: (tp_ItemRub2{ta_ItemRub2}=(->[HeberGement:5]HG_LC_ID:61))  //"Centre"
					
					ARRAY TEXT:C222(ta_ItemEum2; 0)
			End case 
			If ($vb_OK)
				ARRAY TEXT:C222(ta_ItemEum2; 0)
			End if 
			
			
			REDRAW:C174([HeberGement:5])
		End if 
		
End case 