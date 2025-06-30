//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ItemRessources
//{
//{          Mardi 29 mars 2005 à 11:41
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($Pos)

Case of 
	: ($1=0)
		ARRAY TEXT:C222(ta_ItemRub; 31)
		ARRAY POINTER:C280(tp_ItemRub; 31)
		
		ta_ItemRub{1}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{40}  //"Etat Civil"
		tp_ItemRub{1}:=->[HeberGement:5]HG_EtatCivil:20
		
		ta_ItemRub{2}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}  //"Signalement"
		tp_ItemRub{2}:=->[HeberGement:5]HG_Signalement:12
		
		ta_ItemRub{3}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{48}  //"Orientation 1"
		tp_ItemRub{3}:=->[HeberGement:5]HG_Orientation1:58
		
		ta_ItemRub{4}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{49}  //"Orientation 2"
		tp_ItemRub{4}:=->[HeberGement:5]HG_Orientation2:60
		
		ta_ItemRub{5}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}  //"Autre solution"
		tp_ItemRub{5}:=->[HeberGement:5]HG_AutreSolutio:88
		
		ta_ItemRub{6}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12}  //"Nationalité"
		tp_ItemRub{6}:=->[HeberGement:5]HG_Nationalité:25
		
		ta_ItemRub{7}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{13}  //"Situation de Famille"
		tp_ItemRub{7}:=->[HeberGement:5]HG_SituFamille:29
		
		ta_ItemRub{8}:="Date de naissance"
		tp_ItemRub{8}:=->[HeberGement:5]HG_DateNéLe:24
		
		ta_ItemRub{9}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25}  //"Pièces Idté 1"
		tp_ItemRub{9}:=->[HeberGement:5]HG_PiècesIdté1:31
		
		ta_ItemRub{10}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7}  //"Code Postal"
		tp_ItemRub{10}:=->[HeberGement:5]HG_CodePostal:14
		
		ta_ItemRub{11}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{8}  //"Gare"
		tp_ItemRub{11}:=->[HeberGement:5]HG_Gare:15
		
		ta_ItemRub{12}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9}  //"Métro"
		tp_ItemRub{12}:=->[HeberGement:5]HG_Métro:16
		
		ta_ItemRub{13}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{11}  //"Lien de parenté"
		tp_ItemRub{13}:=->[HeberGement:5]HG_Lien:18
		
		ta_ItemRub{14}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{14}  //"Temps d'errance"
		tp_ItemRub{14}:=->[HeberGement:5]HG_TempsErrance:34
		
		ta_ItemRub{15}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{15}  //"Dernier hébergement"
		tp_ItemRub{15}:=->[HeberGement:5]HG_DernierHéber:35
		
		ta_ItemRub{16}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{16}  //"Situation professionnelle"
		tp_ItemRub{16}:=->[HeberGement:5]HG_SituProfess:36
		
		ta_ItemRub{17}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{17}  //"Dernier emploi"
		tp_ItemRub{17}:=->[HeberGement:5]HG_DernierEmplo:37
		
		ta_ItemRub{18}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{18}  //"Duré sans emploi"
		tp_ItemRub{18}:=->[HeberGement:5]HG_DuréSanEmplo:38
		
		ta_ItemRub{19}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28}  //"Rupture majeure 1"
		tp_ItemRub{19}:=->[HeberGement:5]HG_RupMajeur1:40
		
		ta_ItemRub{20}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{31}  //"Ressources 1"
		tp_ItemRub{20}:=->[HeberGement:5]HG_Ressources1:45
		
		ta_ItemRub{21}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{34}  //"Suivi social 1"
		tp_ItemRub{21}:=->[HeberGement:5]HG_SuiviSocial1:49
		
		ta_ItemRub{22}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{37}  //"Couverture sociale 1"
		tp_ItemRub{22}:=->[HeberGement:5]HG_CouvSocial1:53
		
		ta_ItemRub{23}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{41}  //"Niveau d'étude"
		tp_ItemRub{23}:=->[HeberGement:5]HG_NiveauEtude:43
		
		ta_ItemRub{24}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}  //"Famille groupe"
		tp_ItemRub{24}:=->[HeberGement:5]HG_FamGroupe:102
		
		ta_ItemRub{25}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}  //"Centre nom"
		tp_ItemRub{25}:=->[HeberGement:5]HG_CentreNom:62
		
		ta_ItemRub{26}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{100}  //"Plateforme"
		tp_ItemRub{26}:=->[HeberGement:5]HG_Plateforme:139
		
		ta_ItemRub{27}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{3}  //"Permanencier"
		tp_ItemRub{27}:=->[HeberGement:5]HG_Permanencier:9
		
		ta_ItemRub{28}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{64}  //"Famille clé"
		tp_ItemRub{28}:=->[HeberGement:5]HG_FamClé:104
		
		ta_ItemRub{29}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{1}  //"Coordinateur"
		tp_ItemRub{29}:=->[HeberGement:5]HG_Coordinateur:7
		
		ta_ItemRub{30}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{125}  //"Dossier SIAO"
		tp_ItemRub{30}:=->[HeberGement:5]HG_DossierSIAO:164
		
		// Modifié par : Scanu Rémy (09/02/2024)
		// Ajout champ HG_Genre
		ta_ItemRub{31}:="Genre"
		tp_ItemRub{31}:=->[HeberGement:5]HG_Genre:96
		
		ta_ItemRub:=1
		ve_PosRub:=1
	: ($1=1)
		
		Case of 
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_EtatCivil:20))  //"Etat Civil"
				COPY ARRAY:C226(<>ta_TBEtCiv; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Signalement:12))  //"Signalement"
				COPY ARRAY:C226(<>ta_TBSglt; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Orientation1:58))  //"Orientation 1"
				COPY ARRAY:C226(<>ta_TBOr1; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Orientation2:60))  //"Orientation 2"
				COPY ARRAY:C226(<>ta_TBOr2; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_AutreSolutio:88))  //"Autre solution"
				COPY ARRAY:C226(<>ta_AtS; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Nationalité:25))  //"Nationalité"
				COPY ARRAY:C226(<>ta_TBNatio; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_SituFamille:29))  //"Situation de Famille"
				COPY ARRAY:C226(<>ta_TBSitFam; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DateNéLe:24))  //"Date de naissance"
				ARRAY TEXT:C222(<>ta_TBItem; 0)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_PiècesIdté1:31))  //"Pièces Idté 1"
				COPY ARRAY:C226(<>ta_TBPIdté; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_CodePostal:14))  //"Code Postal"
				COPY ARRAY:C226(<>ta_TBArr; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Gare:15))  //"Gare"
				COPY ARRAY:C226(<>ta_TBGare; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Métro:16))  //"Métro"
				COPY ARRAY:C226(<>ta_TBMetro; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Lien:18))  //"Lien de parenté"
				COPY ARRAY:C226(<>ta_TBLien; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_TempsErrance:34))  //"Temps d'errance"
				COPY ARRAY:C226(<>ta_TBTpsErr; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DernierHéber:35))  //"Dernier hébergement"
				COPY ARRAY:C226(<>ta_TBDerHéb; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_SituProfess:36))  //"Situation professionnelle"
				COPY ARRAY:C226(<>ta_TBSitPro; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DernierEmplo:37))  //"Dernier emploi"
				COPY ARRAY:C226(<>ta_TBDerJob; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DuréSanEmplo:38))  //"Duré sans emploi"
				COPY ARRAY:C226(<>ta_TBDurJob; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_RupMajeur1:40))  //"Rupture majeure 1"
				COPY ARRAY:C226(<>ta_TBRupMaj; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Ressources1:45))  //"Ressources 1"
				COPY ARRAY:C226(<>ta_TBResAct; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_SuiviSocial1:49))  //"Suivi social 1"
				COPY ARRAY:C226(<>ta_TBSuiSoc; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_CouvSocial1:53))  //"Couverture sociale 1"
				COPY ARRAY:C226(<>ta_TBCouSoc; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_NiveauEtude:43))  //"Niveau d'étude"
				COPY ARRAY:C226(<>ta_TBNivEtu; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_FamGroupe:102))  //"Famille groupe"
				COPY ARRAY:C226(<>ta_FMGrp; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_CentreNom:62))  //"Centre nom"
				ARRAY TEXT:C222(<>ta_TBItem; 0)
				
				ALL RECORDS:C47([LesCentres:9])
				MultiSoc_Filter(->[LesCentres:9])
				
				ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
				SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; <>tl_TBItemCerntre; [LesCentres:9]LC_Nom:4; <>ta_TBItemCerntre)
				
				OBJECT SET VISIBLE:C603(<>ta_TBItem; False:C215)
				OBJECT SET VISIBLE:C603(<>ta_TBItemCerntre; True:C214)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Plateforme:139))  //"Plateforme"
				COPY ARRAY:C226(<>ta_Plateforme; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Permanencier:9))  //"Permanencier"
				COPY ARRAY:C226(<>ta_InPerm; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_FamClé:104))  //"Famille clé"
				ARRAY TEXT:C222(<>ta_TBItem; 0)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Coordinateur:7))  //"Coordinateur"
				COPY ARRAY:C226(<>ta_InCoo; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_DossierSIAO:164))  //"DossierSIAO"        
				COPY ARRAY:C226(<>ta_HG_DosSIAO; <>ta_TBItem)
			: (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Genre:96))  //"Genre"
				ARRAY TEXT:C222(<>ta_TBItem; 0)
		End case 
		
	: ($1=2)
		
		If ($2>0)
			ve_PosRub:=$2
			va_TitItem:=ta_ItemRub{$2}
			
			OBJECT SET VISIBLE:C603(<>ta_TBItem; True:C214)
			OBJECT SET VISIBLE:C603(<>ta_TBItemCerntre; False:C215)
			
			P_ItemRessources(1; $2)
			SORT ARRAY:C229(ta_ItemRub; tp_ItemRub; >)
			
			va_IDT_Typ1:=""
			va_IDT_Typ2:=""
			
			<>vl_TBItemCtreID:=0
			<>ta_TBItem:=0
			<>ta_TBItemCerntre:=0
			
			If (Size of array:C274(<>ta_TBItem)>0)
				<>ta_TBItem:=1
			End if 
			
			If (Size of array:C274(<>ta_TBItemCerntre)>0)
				<>ta_TBItemCerntre:=1
			End if 
			
			REDRAW:C174([HeberGement:5])
			$Pos:=Find in array:C230(ta_ItemRub; va_TitItem)
			
			If ($Pos<=0)
				$Pos:=1
			End if 
			
			ta_ItemRub:=$Pos
		Else 
			ta_ItemRub:=ve_PosRub
		End if 
		
End case 