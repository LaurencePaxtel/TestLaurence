//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{          Procédure : DébutDécTableCritèreVeille
//{          Lundi 26 juillet 2004 à 11:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//••• TABLEAU •••
C_LONGINT:C283($1)

C_LONGINT:C283($i; $L_Size; $j)

Case of 
	: ($1=0)
		//Etat civil
		ARRAY TEXT:C222(<>ta_VeilEtCiv; 0)
		ARRAY INTEGER:C220(<>te_VeilEtCiv; 0)
		
		//Signalement
		ARRAY TEXT:C222(<>ta_VeilSglt; 0)
		ARRAY INTEGER:C220(<>te_VeilSglt; 0)
		
		//groupes
		ARRAY TEXT:C222(<>ta_VeilGroupe; 0)
		ARRAY INTEGER:C220(<>te_VeilGroupe; 0)
		
		//perma
		ARRAY TEXT:C222(<>ta_VeilPerma; 0)
		ARRAY INTEGER:C220(<>te_VeilPerma; 0)
		
		//regulateur
		ARRAY TEXT:C222(<>ta_VeilRegulateur; 0)
		ARRAY INTEGER:C220(<>te_VeilRegulateur; 0)
		
		//Autres solutions : 23/4/2004
		ARRAY TEXT:C222(<>ta_VeilAutreSol; 0)
		ARRAY INTEGER:C220(<>te_VeilAutreSol; 0)
		
		//Orientation1 : 26/7/2004
		ARRAY TEXT:C222(<>ta_VeilOrient1; 0)
		ARRAY INTEGER:C220(<>te_VeilOrient1; 0)
		
		//Orientation2 : 26/7/2004
		ARRAY TEXT:C222(<>ta_VeilOrient2; 0)
		ARRAY INTEGER:C220(<>te_VeilOrient2; 0)
		
		//Ruptures majeures : 26/7/2004
		ARRAY TEXT:C222(<>ta_VeilRupMaj1; 0)
		ARRAY INTEGER:C220(<>te_VeilRupMaj1; 0)
		
		ARRAY TEXT:C222(<>ta_VeilRupMaj2; 0)
		ARRAY INTEGER:C220(<>te_VeilRupMaj2; 0)
		
		ARRAY TEXT:C222(<>ta_VeilRupMaj3; 0)
		ARRAY INTEGER:C220(<>te_VeilRupMaj3; 0)
		
		ARRAY TEXT:C222(<>ta_Veilidt1; 0)
		ARRAY INTEGER:C220(<>te_Veilidt1; 0)
		
		ARRAY TEXT:C222(<>ta_Veilidt2; 0)
		ARRAY INTEGER:C220(<>te_Veilidt2; 0)
		
		ARRAY TEXT:C222(<>ta_Veilidt3; 0)
		ARRAY INTEGER:C220(<>te_Veilidt3; 0)
		
		ARRAY TEXT:C222(<>ta_VeilDistri5; 0)
		ARRAY INTEGER:C220(<>te_VeilDistri5; 0)
		
		//Ressources : 10/1/2008
		ARRAY TEXT:C222(<>ta_VeilRess1; 0)
		ARRAY INTEGER:C220(<>te_VeilRess1; 0)
		
		ARRAY TEXT:C222(<>ta_VeilRess2; 0)
		ARRAY INTEGER:C220(<>te_VeilRess2; 0)
		
		ARRAY TEXT:C222(<>ta_VeilRess3; 0)
		ARRAY INTEGER:C220(<>te_VeilRess3; 0)
		
		//Suivi social : 10/1/2008
		ARRAY TEXT:C222(<>ta_VeilSSoc1; 0)
		ARRAY INTEGER:C220(<>te_VeilSSoc1; 0)
		
		ARRAY TEXT:C222(<>ta_VeilSSoc2; 0)
		ARRAY INTEGER:C220(<>te_VeilSSoc2; 0)
		
		ARRAY TEXT:C222(<>ta_VeilSSoc3; 0)
		ARRAY INTEGER:C220(<>te_VeilSSoc3; 0)
		
		//Couverture social : 10/1/2008
		ARRAY TEXT:C222(<>ta_VeilCSoc1; 0)
		ARRAY INTEGER:C220(<>te_VeilCSoc1; 0)
		
		ARRAY TEXT:C222(<>ta_VeilCSoc2; 0)
		ARRAY INTEGER:C220(<>te_VeilCSoc2; 0)
		
		ARRAY TEXT:C222(<>ta_VeilCSoc3; 0)
		ARRAY INTEGER:C220(<>te_VeilCSoc3; 0)
		
		ARRAY TEXT:C222(<>ta_VeilNivEt; 0)
		ARRAY INTEGER:C220(<>te_VeilNivEt; 0)
		
		ARRAY TEXT:C222(<>ta_VeilTpsEr; 0)
		ARRAY INTEGER:C220(<>te_VeilTpsEr; 0)
		
		ARRAY TEXT:C222(<>ta_VeilMetro; 0)
		ARRAY INTEGER:C220(<>te_VeilMetro; 0)
		
		ARRAY TEXT:C222(<>ta_VeilGare; 0)
		ARRAY INTEGER:C220(<>te_VeilGare; 0)
		
		ARRAY TEXT:C222(<>ta_VeilPlateforme; 0)
		ARRAY INTEGER:C220(<>te_VeilPlateforme; 0)
		
		ARRAY TEXT:C222(<>ta_VeilCasSpe; 0)
		ARRAY INTEGER:C220(<>te_VeilCasSpe; 0)
		
		ARRAY TEXT:C222(<>ta_VeilDosSIAO; 0)
		ARRAY INTEGER:C220(<>te_VeilDosSIAO; 0)
		
		ARRAY TEXT:C222(<>ta_VeilCentre; 0)
		ARRAY LONGINT:C221(<>tl_VeilCentre; 0)
		ARRAY INTEGER:C220(<>te_VeilCentre; 0)
		
		C_TEXT:C284(<>va_VeilCentrePrefixe)
		
		// FamCasSpec
		ARRAY TEXT:C222(<>ta_VeilFMCaS; 0)
		ARRAY INTEGER:C220(<>te_VeilFMCaS; 0)
		
		// Orientation 1 suite
		ARRAY TEXT:C222(<>ta_VeilTBOr1suite; 0)  // 17/2/17
		ARRAY INTEGER:C220(<>te_VeilTBOr1suite; 0)
		
		// Autre solution suite
		ARRAY TEXT:C222(<>ta_VeilAtSsuite; 0)  // 17/2/17
		ARRAY INTEGER:C220(<>te_VeilAtSsuite; 0)
		
		// Réservation provisoire
		ARRAY TEXT:C222(<>ta_ReservationProvisoire; 0)  // 10/08/2022
		ARRAY INTEGER:C220(<>te_ReservationProvisoire; 0)
		
		// Nationalité
		ARRAY TEXT:C222(<>ta_Nationalite; 0)  // 10/08/2022
		ARRAY INTEGER:C220(<>te_Nationalite; 0)
		
		// Assistance social
		ARRAY TEXT:C222(<>ta_AssistanteSociale; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_AssistanteSociale; 0)
		
		// Code postal
		ARRAY TEXT:C222(<>ta_CodePostal; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_CodePostal; 0)
		
		// Coordinateur
		ARRAY TEXT:C222(<>ta_Coordinateur; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_Coordinateur; 0)
		
		// Dernier emploi
		ARRAY TEXT:C222(<>ta_DernierEmploi; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_DernierEmploi; 0)
		
		// Dernier Hébergement
		ARRAY TEXT:C222(<>ta_DernierHebergement; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_DernierHebergement; 0)
		
		// Durée sans emploi
		ARRAY TEXT:C222(<>ta_DureeSansEmploi; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_DureeSansEmploi; 0)
		
		// Genre
		ARRAY TEXT:C222(<>ta_Genre; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_Genre; 0)
		
		// Lien
		ARRAY TEXT:C222(<>ta_Lien; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_Lien; 0)
		
		// Situation famille
		ARRAY TEXT:C222(<>ta_SituationFamille; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_SituationFamille; 0)
		
		// Situation professionnelle
		ARRAY TEXT:C222(<>ta_SituationProf; 0)  // 19/12/2022
		ARRAY INTEGER:C220(<>te_SituationProf; 0)
		
		// Emplacement
		ARRAY INTEGER:C220(<>te_Emplacement; 0)  // 27/03/2023
	: ($1=1)
		ALL RECORDS:C47([LesCentres:9])
		MultiSoc_Filter(->[LesCentres:9])
		
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Niveau:52; >; *)
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		
		SELECTION TO ARRAY:C260([LesCentres:9]LC_Nom:4; <>ta_VeilCentre; [LesCentres:9]LC_RéférenceID:1; <>tl_VeilCentre)
		$L_Size:=Size of array:C274(<>ta_VeilCentre)
		
		ARRAY INTEGER:C220(<>te_VeilCentre; $L_Size)
		
		For ($i; 1; $L_Size)
			<>te_VeilCentre{$i}:=1
		End for 
		
		<>va_VeilCentrePrefixe:=""
		
		For ($j; 1; 46)
			
			Case of 
				: ($j=1)  // Etat civil 
					$P_Tableau_source:=-><>ta_TBEtCiv
					$P_Tableau_e:=-><>te_VeilEtCiv
					$P_Tableau_a:=-><>ta_VeilEtCiv
				: ($j=2)  // Signalement
					$P_Tableau_source:=-><>ta_TBSglt
					$P_Tableau_e:=-><>te_VeilSglt
					$P_Tableau_a:=-><>ta_VeilSglt
				: ($j=3)
					$P_Tableau_source:=-><>ta_FMGrpX
					$P_Tableau_e:=-><>te_VeilGroupe
					$P_Tableau_a:=-><>ta_VeilGroupe
				: ($j=4)  // Permanancier
					$P_Tableau_source:=-><>ta_InPerm
					$P_Tableau_e:=-><>te_VeilPerma
					$P_Tableau_a:=-><>ta_VeilPerma
				: ($j=5)  // Autres solutions : 23/4/2004
					$P_Tableau_source:=-><>ta_AtS
					$P_Tableau_e:=-><>te_VeilAutreSol
					$P_Tableau_a:=-><>ta_VeilAutreSol
				: ($j=6)  // Orientation1 : 26/7/2004
					$P_Tableau_source:=-><>ta_TBOr1
					$P_Tableau_e:=-><>te_VeilOrient1
					$P_Tableau_a:=-><>ta_VeilOrient1
				: ($j=7)  // Orientation 1 suite 17/2/17
					$P_Tableau_source:=-><>ta_TBOr1suite
					$P_Tableau_e:=-><>te_VeilTBOr1suite
					$P_Tableau_a:=-><>ta_VeilTBOr1suite
				: ($j=8)  // Autre solution suite 17/2/17
					$P_Tableau_source:=-><>ta_AtSsuite
					$P_Tableau_e:=-><>te_VeilAtSsuite
					$P_Tableau_a:=-><>ta_VeilAtSsuite
				: ($j=9)  // Orientation2 : 26/7/2004
					$P_Tableau_source:=-><>ta_TBOr2
					$P_Tableau_e:=-><>te_VeilOrient2
					$P_Tableau_a:=-><>ta_VeilOrient2
				: ($j=10)  // Ruptures majeures : 26/7/2004
					$P_Tableau_source:=-><>ta_TBRupMaj
					$P_Tableau_e:=-><>te_VeilRupMaj1
					$P_Tableau_a:=-><>ta_VeilRupMaj1
				: ($j=11)
					$P_Tableau_source:=-><>ta_TBRupMaj2
					$P_Tableau_e:=-><>te_VeilRupMaj2
					$P_Tableau_a:=-><>ta_VeilRupMaj2
				: ($j=12)
					$P_Tableau_source:=-><>ta_TBRupMaj3
					$P_Tableau_e:=-><>te_VeilRupMaj3
					$P_Tableau_a:=-><>ta_VeilRupMaj3
				: ($j=13)
					$P_Tableau_source:=-><>ta_TBPIdté
					$P_Tableau_e:=-><>te_Veilidt1
					$P_Tableau_a:=-><>ta_Veilidt1
				: ($j=14)
					$P_Tableau_source:=-><>ta_TBPIdté2
					$P_Tableau_e:=-><>te_Veilidt2
					$P_Tableau_a:=-><>ta_Veilidt2
				: ($j=15)
					$P_Tableau_source:=-><>ta_TBPIdté3
					$P_Tableau_e:=-><>te_Veilidt3
					$P_Tableau_a:=-><>ta_Veilidt3
				: ($j=16)
					$P_Tableau_source:=-><>ta_FMDis5
					$P_Tableau_e:=-><>te_VeilDistri5
					$P_Tableau_a:=-><>ta_VeilDistri5
				: ($j=17)  // Ressources : 10/1/2008
					$P_Tableau_source:=-><>ta_TBResAct
					$P_Tableau_e:=-><>te_VeilRess1
					$P_Tableau_a:=-><>ta_VeilRess1
				: ($j=18)
					$P_Tableau_source:=-><>ta_TBResAct
					$P_Tableau_e:=-><>te_VeilRess2
					$P_Tableau_a:=-><>ta_VeilRess2
				: ($j=19)
					$P_Tableau_source:=-><>ta_TBResAct
					$P_Tableau_e:=-><>te_VeilRess3
					$P_Tableau_a:=-><>ta_VeilRess3
				: ($j=20)  // Suivi social : 10/1/2008
					$P_Tableau_source:=-><>ta_TBSuiSoc
					$P_Tableau_e:=-><>te_VeilSSoc1
					$P_Tableau_a:=-><>ta_VeilSSoc1
				: ($j=21)
					$P_Tableau_source:=-><>ta_TBSuiSoc
					$P_Tableau_e:=-><>te_VeilSSoc2
					$P_Tableau_a:=-><>ta_VeilSSoc2
				: ($j=22)
					$P_Tableau_source:=-><>ta_TBSuiSoc
					$P_Tableau_e:=-><>te_VeilSSoc3
					$P_Tableau_a:=-><>ta_VeilSSoc3
				: ($j=23)  // Couverture social : 10/1/2008
					$P_Tableau_source:=-><>ta_TBCouSoc
					$P_Tableau_e:=-><>te_VeilCSoc1
					$P_Tableau_a:=-><>ta_VeilCSoc1
				: ($j=24)
					$P_Tableau_source:=-><>ta_TBCouSoc
					$P_Tableau_e:=-><>te_VeilCSoc2
					$P_Tableau_a:=-><>ta_VeilCSoc2
				: ($j=25)
					$P_Tableau_source:=-><>ta_TBCouSoc
					$P_Tableau_e:=-><>te_VeilCSoc3
					$P_Tableau_a:=-><>ta_VeilCSoc3
				: ($j=26)  // Niveau d'étude : 7/7/2008
					$P_Tableau_source:=-><>ta_TBNivEtu
					$P_Tableau_e:=-><>te_VeilNivEt
					$P_Tableau_a:=-><>ta_VeilNivEt
				: ($j=27)  // Temps d'errance : 7/7/2008
					$P_Tableau_source:=-><>ta_TBTpsErr
					$P_Tableau_e:=-><>te_VeilTpsEr
					$P_Tableau_a:=-><>ta_VeilTpsEr
				: ($j=28)  // Metro : 7/7/2008
					$P_Tableau_source:=-><>ta_TBMetro
					$P_Tableau_e:=-><>te_VeilMetro
					$P_Tableau_a:=-><>ta_VeilMetro
				: ($j=29)  // Gare : 12/1/2009
					$P_Tableau_source:=-><>ta_TBGare
					$P_Tableau_e:=-><>te_VeilGare
					$P_Tableau_a:=-><>ta_VeilGare
				: ($j=30)  // Plateforme : 3/2/2009
					$P_Tableau_source:=-><>ta_Plateforme
					$P_Tableau_e:=-><>te_VeilPlateforme
					$P_Tableau_a:=-><>ta_VeilPlateforme
				: ($j=31)  // Dossier SIAO : 16/1/2011
					$P_Tableau_source:=-><>ta_HG_DosSIAO
					$P_Tableau_e:=-><>te_VeilDosSIAO
					$P_Tableau_a:=-><>ta_VeilDosSIAO
				: ($j=32)  // FamCasSpec : 13/3/2009
					$P_Tableau_source:=-><>ta_FMCaS
					$P_Tableau_e:=-><>te_VeilFMCaS
					$P_Tableau_a:=-><>ta_VeilFMCaS
				: ($j=33)  // Régulateur
					// Modifié par : Scanu Rémy - remy@connect-io.fr (25/02/2021)
					QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=3)
					MultiSoc_Filter(->[INtervenants:10])
					
					SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InRég)
					SORT ARRAY:C229(<>ta_InRég; >)
					
					$P_Tableau_source:=-><>ta_InRég
					$P_Tableau_e:=-><>te_VeilRegulateur
					$P_Tableau_a:=-><>ta_VeilRegulateur
				: ($j=34)  // Réservation provisoire
					// Modifié par : Scanu Rémy - remy@connect-io.fr (10/08/2022)
					ARRAY TEXT:C222($choixPossible_at; 0)
					
					outilsAddToArray(->$choixPossible_at; "Oui"; "Non")
					$P_Tableau_source:=->$choixPossible_at
					
					$P_Tableau_e:=-><>te_ReservationProvisoire
					$P_Tableau_a:=-><>ta_ReservationProvisoire
				: ($j=35)  // Nationalité
					// Modifié par : Scanu Rémy - remy@connect-io.fr (21/10/2022)
					$P_Tableau_source:=-><>ta_TBNatio
					$P_Tableau_e:=-><>te_Nationalite
					$P_Tableau_a:=-><>ta_Nationalite
				: ($j=36)  // Assistante sociale
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					$P_Tableau_source:=-><>ta_InAsSoc
					$P_Tableau_e:=-><>te_AssistanteSociale
					$P_Tableau_a:=-><>ta_AssistanteSociale
				: ($j=37)  // Code postal
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					$P_Tableau_source:=-><>ta_TBArr
					$P_Tableau_e:=-><>te_CodePostal
					$P_Tableau_a:=-><>ta_CodePostal
				: ($j=38)  // Coordinateur
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					$P_Tableau_source:=-><>ta_InCoo
					$P_Tableau_e:=-><>te_Coordinateur
					$P_Tableau_a:=-><>ta_Coordinateur
				: ($j=39)  // Dernier emploi
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					$P_Tableau_source:=-><>ta_TBDerJob
					$P_Tableau_e:=-><>te_DernierEmploi
					$P_Tableau_a:=-><>ta_DernierEmploi
				: ($j=40)  // Dernier hébérgement
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					$P_Tableau_source:=-><>ta_TBDerHéb
					$P_Tableau_e:=-><>te_DernierHebergement
					$P_Tableau_a:=-><>ta_DernierHebergement
				: ($j=41)  // Durée sans emploi
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					$P_Tableau_source:=-><>ta_TBDurJob
					$P_Tableau_e:=-><>te_DureeSansEmploi
					$P_Tableau_a:=-><>ta_DureeSansEmploi
				: ($j=42)  // Genre
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					ARRAY TEXT:C222($choixPossible_at; 0)
					
					outilsAddToArray(->$choixPossible_at; "Homme"; "Femme")
					$P_Tableau_source:=->$choixPossible_at
					
					$P_Tableau_e:=-><>te_Genre
					$P_Tableau_a:=-><>ta_Genre
				: ($j=43)  // Lien
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					$P_Tableau_source:=-><>ta_TBLien
					$P_Tableau_e:=-><>te_Lien
					$P_Tableau_a:=-><>ta_Lien
				: ($j=44)  // Situation famille
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					$P_Tableau_source:=-><>ta_TBSitFam
					$P_Tableau_e:=-><>te_SituationFamille
					$P_Tableau_a:=-><>ta_SituationFamille
				: ($j=45)  // Situation professionnelle
					// Modifié par : Scanu Rémy - remy@connect-io.fr (19/12/2022)
					$P_Tableau_source:=-><>ta_TBSitPro
					$P_Tableau_e:=-><>te_SituationProf
					$P_Tableau_a:=-><>ta_SituationProf
				: ($j=46)  // Emplacement
					// Modifié par : Scanu Rémy - remy@connect-io.fr (27/03/2023)
					$P_Tableau_source:=-><>ta_Emplacement
					$P_Tableau_e:=-><>te_Emplacement
					$P_Tableau_a:=-><>ta_Emplacement
				Else 
					//TRACE
			End case 
			
			$L_Size:=Size of array:C274($P_Tableau_source->)
			
			COPY ARRAY:C226($P_Tableau_source->; $P_Tableau_a->)
			ARRAY INTEGER:C220($P_Tableau_e->; $L_Size)
			
			For ($i; 1; $L_Size)
				$P_Tableau_e->{$i}:=1
			End for 
			
		End for 
		
	: ($1=2)
		// Modifié par : Scanu Rémy (10/08/2022)
		// Ajout du filtre "Réservation provisoire"
		
		// Modifié par : Scanu Rémy (21/10/2022)
		// Ajout du filtre "Nationalité"
		
		// Modifié par : Scanu Rémy (19/12/2022)
		// Ajout des filtres "Assistante sociale", "Code postal", "Coordinateur", "Dernier emploi", "Dernier hébérgement", "Durée sans emploi", "Genre", "Lien", "Situation famille", "Situation professionnelle"
		
		// Modifié par : Scanu Rémy (27/03/2023)
		// Ajout des filtres "Emplacement"
		ARRAY TEXT:C222(ta_xCritères; 47)
		ARRAY INTEGER:C220(te_xCritères; Size of array:C274(ta_xCritères))
		
		For ($i; 1; Size of array:C274(ta_xCritères))
			te_xCritères{$i}:=0
		End for 
		
		ta_xCritères{1}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{40}
		ta_xCritères{2}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}
		
		ta_xCritères{3}:="Permanencier"
		
		ta_xCritères{4}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}
		ta_xCritères{5}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}
		ta_xCritères{6}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{48}
		
		ta_xCritères{7}:="Orientation 1 suite"  // inséré ici 17/217
		ta_xCritères{8}:="Autre solution suite"  // inséré ici 17/217
		
		ta_xCritères{9}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{49}
		ta_xCritères{10}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28}
		ta_xCritères{11}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{29}
		ta_xCritères{12}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{30}
		
		ta_xCritères{13}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25}
		ta_xCritères{14}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{26}
		ta_xCritères{15}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{27}
		ta_xCritères{16}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{82}
		
		ta_xCritères{17}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{31}
		ta_xCritères{18}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{32}
		ta_xCritères{19}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{33}
		
		ta_xCritères{20}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{34}
		ta_xCritères{21}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{35}
		ta_xCritères{22}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{36}
		
		ta_xCritères{23}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{37}
		ta_xCritères{24}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{38}
		ta_xCritères{25}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{39}
		
		ta_xCritères{26}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{41}
		ta_xCritères{27}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{14}
		ta_xCritères{28}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9}
		ta_xCritères{29}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{8}
		ta_xCritères{30}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{100}
		
		ta_xCritères{31}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{125}
		ta_xCritères{32}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}
		
		ta_xCritères{33}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{83}
		
		ta_xCritères{34}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{2}
		
		// Modifié par : Scanu Rémy (10/08/2022)
		ta_xCritères{35}:="Réservation provisoire"
		
		// Modifié par : Scanu Rémy (21/08/2022)
		ta_xCritères{36}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12}
		
		// Modifié par : Scanu Rémy (19/12/2022)
		ta_xCritères{37}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{4}
		ta_xCritères{38}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7}
		ta_xCritères{39}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{1}
		ta_xCritères{40}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{17}
		ta_xCritères{41}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{15}
		ta_xCritères{42}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{18}
		ta_xCritères{43}:="Genre"
		ta_xCritères{44}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{11}
		ta_xCritères{45}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{13}
		ta_xCritères{46}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{16}
		ta_xCritères{47}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{10}
		
		ta_xCritères:=1
		ta_xCritères{0}:=ta_xCritères{ta_xCritères}
	: ($1=3)
		
		If (Size of array:C274(ta_xCritères)>0)
			
			If (ta_xCritères>0)
				
				Case of 
					: (ta_xCritères=1)  // Etat civil
						P_HébergementCritères(-><>ta_VeilEtCiv; -><>te_VeilEtCiv; ta_xCritères{ta_xCritères})
					: (ta_xCritères=2)  // Groupe
						P_HébergementCritères(-><>ta_VeilGroupe; -><>te_VeilGroupe; ta_xCritères{ta_xCritères})
					: (ta_xCritères=3)  // Permanencier
						
						If (<>vb_UserLOFT)
							StrAlerte(6; "Permanencier")
							ta_xCritères:=Find in array:C230(ta_xCritères; ta_xCritères{0})
						Else 
							P_HébergementCritères(-><>ta_VeilPerma; -><>te_VeilPerma; ta_xCritères{ta_xCritères})
						End if 
						
					: (ta_xCritères=4)  // Signalement
						P_HébergementCritères(-><>ta_VeilSglt; -><>te_VeilSglt; ta_xCritères{ta_xCritères})
					: (ta_xCritères=5)  // Autre solution
						P_HébergementCritères(-><>ta_VeilAutreSol; -><>te_VeilAutreSol; ta_xCritères{ta_xCritères})
					: (ta_xCritères=6)  // Orientation1
						P_HébergementCritères(-><>ta_VeilOrient1; -><>te_VeilOrient1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=7)  // Orientation 1
						P_HébergementCritères(-><>ta_VeilTBOr1suite; -><>te_VeilTBOr1suite; ta_xCritères{ta_xCritères})
					: (ta_xCritères=8)  // Autre solution suite
						P_HébergementCritères(-><>ta_VeilAtSsuite; -><>te_VeilAtSsuite; ta_xCritères{ta_xCritères})
					: (ta_xCritères=9)  // Orientation 2
						P_HébergementCritères(-><>ta_VeilOrient2; -><>te_VeilOrient2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=10)  // Ruptures majeures 1
						P_HébergementCritères(-><>ta_VeilRupMaj1; -><>te_VeilRupMaj1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=11)  // Ruptures majeures 2
						P_HébergementCritères(-><>ta_VeilRupMaj2; -><>te_VeilRupMaj2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=12)  // Ruptures majeures 3
						P_HébergementCritères(-><>ta_VeilRupMaj3; -><>te_VeilRupMaj3; ta_xCritères{ta_xCritères})
					: (ta_xCritères=13)  // Identité 1
						P_HébergementCritères(-><>ta_Veilidt1; -><>te_Veilidt1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=14)  // Identité 2
						P_HébergementCritères(-><>ta_Veilidt2; -><>te_Veilidt2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=15)  // Identité 3
						P_HébergementCritères(-><>ta_Veilidt3; -><>te_Veilidt2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=16)  // Distribution 5
						P_HébergementCritères(-><>ta_VeilDistri5; -><>te_VeilDistri5; ta_xCritères{ta_xCritères})
					: (ta_xCritères=17)  // Ressources 1
						P_HébergementCritères(-><>ta_VeilRess1; -><>te_VeilRess1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=18)  // Ressources 2
						P_HébergementCritères(-><>ta_VeilRess2; -><>te_VeilRess2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=19)  // Ressources 3
						P_HébergementCritères(-><>ta_VeilRess3; -><>te_VeilRess3; ta_xCritères{ta_xCritères})
					: (ta_xCritères=20)  // Suivi social 1
						P_HébergementCritères(-><>ta_VeilSSoc1; -><>te_VeilSSoc1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=21)  // Suivi social 2
						P_HébergementCritères(-><>ta_VeilSSoc2; -><>te_VeilSSoc2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=22)  // Suivi social 3
						P_HébergementCritères(-><>ta_VeilSSoc3; -><>te_VeilSSoc3; ta_xCritères{ta_xCritères})
					: (ta_xCritères=23)  // Couverture sociale 1
						P_HébergementCritères(-><>ta_VeilCSoc1; -><>te_VeilCSoc1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=24)  // Couverture sociale 2
						P_HébergementCritères(-><>ta_VeilCSoc2; -><>te_VeilCSoc2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=25)  // Couverture sociale 3
						P_HébergementCritères(-><>ta_VeilCSoc3; -><>te_VeilCSoc3; ta_xCritères{ta_xCritères})
					: (ta_xCritères=26)  // Niveau d'étude
						P_HébergementCritères(-><>ta_VeilNivEt; -><>te_VeilNivEt; ta_xCritères{ta_xCritères})
					: (ta_xCritères=27)  // Temps d'errance
						P_HébergementCritères(-><>ta_VeilTpsEr; -><>te_VeilTpsEr; ta_xCritères{ta_xCritères})
					: (ta_xCritères=28)  // Metro
						P_HébergementCritères(-><>ta_VeilMetro; -><>te_VeilMetro; ta_xCritères{ta_xCritères})
					: (ta_xCritères=29)  // Gare
						P_HébergementCritères(-><>ta_VeilGare; -><>te_VeilGare; ta_xCritères{ta_xCritères})
					: (ta_xCritères=30)  // Plateforme
						P_HébergementCritères(-><>ta_VeilPlateforme; -><>te_VeilPlateforme; ta_xCritères{ta_xCritères})
					: (ta_xCritères=31)  // Dossier Orientation SIAO
						P_HébergementCritères(-><>ta_VeilDosSIAO; -><>te_VeilDosSIAO; ta_xCritères{ta_xCritères})
					: (ta_xCritères=32)  // Centres
						P_HébergementCritCentre
					: (ta_xCritères=33)  // FamCasSpec
						P_HébergementCritères(-><>ta_VeilFMCaS; -><>te_VeilFMCaS; ta_xCritères{ta_xCritères})
					: (ta_xCritères=34)  // Régulateur
						P_HébergementCritères(-><>ta_VeilRegulateur; -><>te_VeilRegulateur; ta_xCritères{ta_xCritères})
					: (ta_xCritères=35)  // Réservation provisoire
						P_HébergementCritères(-><>ta_ReservationProvisoire; -><>te_ReservationProvisoire; ta_xCritères{ta_xCritères})
					: (ta_xCritères=36)  // Nationalité
						P_HébergementCritères(-><>ta_Nationalite; -><>te_Nationalite; ta_xCritères{ta_xCritères})
					: (ta_xCritères=37)  // Assistante sociale
						P_HébergementCritères(-><>ta_AssistanteSociale; -><>te_AssistanteSociale; ta_xCritères{ta_xCritères})
					: (ta_xCritères=38)  // Code postal
						P_HébergementCritères(-><>ta_CodePostal; -><>te_CodePostal; ta_xCritères{ta_xCritères})
					: (ta_xCritères=39)  // Coordinateur
						P_HébergementCritères(-><>ta_Coordinateur; -><>te_Coordinateur; ta_xCritères{ta_xCritères})
					: (ta_xCritères=40)  // Dernier emploi
						P_HébergementCritères(-><>ta_DernierEmploi; -><>te_DernierEmploi; ta_xCritères{ta_xCritères})
					: (ta_xCritères=41)  // Dernier hébergement
						P_HébergementCritères(-><>ta_DernierHebergement; -><>te_DernierHebergement; ta_xCritères{ta_xCritères})
					: (ta_xCritères=42)  // Durée sans emploi
						P_HébergementCritères(-><>ta_DureeSansEmploi; -><>te_DureeSansEmploi; ta_xCritères{ta_xCritères})
					: (ta_xCritères=43)  // Genre
						P_HébergementCritères(-><>ta_Genre; -><>te_Genre; ta_xCritères{ta_xCritères})
					: (ta_xCritères=44)  // Lien
						P_HébergementCritères(-><>ta_Lien; -><>te_Lien; ta_xCritères{ta_xCritères})
					: (ta_xCritères=45)  // Situation famille
						P_HébergementCritères(-><>ta_SituationFamille; -><>te_SituationFamille; ta_xCritères{ta_xCritères})
					: (ta_xCritères=46)  // Situation professionnelle
						P_HébergementCritères(-><>ta_SituationProf; -><>te_SituationProf; ta_xCritères{ta_xCritères})
				End case 
				
				ta_xCritères{0}:=ta_xCritères{ta_xCritères}
			End if 
			
		End if 
		
	: ($1=4)
		
		// Etat civil    
		For ($i; 1; Size of array:C274(<>ta_VeilEtCiv))
			<>te_VeilEtCiv{$i}:=1
		End for 
		
		// Signalement
		For ($i; 1; Size of array:C274(<>ta_VeilSglt))
			<>te_VeilSglt{$i}:=1
		End for 
		
		// Groupes
		COPY ARRAY:C226(<>ta_FMGrpX; <>ta_VeilGroupe)
		COPY ARRAY:C226(<>te_FMGrpCK; <>te_VeilGroupe)
		
		// Permanancier
		COPY ARRAY:C226(<>ta_InPerm; <>ta_VeilPerma)
		COPY ARRAY:C226(<>te_InPermCK; <>te_VeilPerma)
		
		// Regulateur
		COPY ARRAY:C226(<>ta_InRég; <>ta_VeilRegulateur)
		COPY ARRAY:C226(<>te_InPermCK; <>te_VeilRegulateur)
		
		// Autres solutions
		For ($i; 1; Size of array:C274(<>ta_VeilAutreSol))
			<>te_VeilAutreSol{$i}:=1
		End for 
		
		// Orientaion 1 suite 17/2/17
		For ($i; 1; Size of array:C274(<>ta_VeilTBOr1suite))
			<>te_VeilTBOr1suite{$i}:=1
		End for 
		
		// Autre solution suite 17/2/17
		For ($i; 1; Size of array:C274(<>ta_VeilAtSsuite))
			<>te_VeilAtSsuite{$i}:=1
		End for 
		
		// Orientation1 
		For ($i; 1; Size of array:C274(<>ta_VeilOrient1))
			<>te_VeilOrient1{$i}:=1
		End for 
		
		// Orientation2
		For ($i; 1; Size of array:C274(<>ta_VeilOrient2))
			<>te_VeilOrient2{$i}:=1
		End for 
		
		// Ruptures majeures
		For ($i; 1; Size of array:C274(<>ta_VeilRupMaj1))
			<>te_VeilRupMaj1{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_VeilRupMaj2))
			<>te_VeilRupMaj2{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_VeilRupMaj3))
			<>te_VeilRupMaj3{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_Veilidt1))
			<>te_Veilidt1{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_Veilidt2))
			<>te_Veilidt2{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_Veilidt3))
			<>te_Veilidt3{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_VeilDistri5))
			<>te_VeilDistri5{$i}:=1
		End for 
		
		// Ressources
		For ($i; 1; Size of array:C274(<>ta_VeilRess1))
			<>te_VeilRess1{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_VeilRess2))
			<>te_VeilRess2{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_VeilRess3))
			<>te_VeilRess3{$i}:=1
		End for 
		
		//Suivi social : 
		For ($i; 1; Size of array:C274(<>ta_VeilSSoc1))
			<>te_VeilSSoc1{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_VeilSSoc2))
			<>te_VeilSSoc2{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_VeilSSoc3))
			<>te_VeilSSoc3{$i}:=1
		End for 
		
		// Couverture social
		For ($i; 1; Size of array:C274(<>ta_VeilCSoc1))
			<>te_VeilCSoc1{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_VeilCSoc2))
			<>te_VeilCSoc2{$i}:=1
		End for 
		
		For ($i; 1; Size of array:C274(<>ta_VeilCSoc3))
			<>te_VeilCSoc3{$i}:=1
		End for 
		
		// Niveau d'étude
		For ($i; 1; Size of array:C274(<>ta_VeilNivEt))
			<>te_VeilNivEt{$i}:=1
		End for 
		
		// Temps d'errance
		For ($i; 1; Size of array:C274(<>ta_VeilTpsEr))
			<>te_VeilTpsEr{$i}:=1
		End for 
		
		// Metro
		For ($i; 1; Size of array:C274(<>ta_VeilMetro))
			<>te_VeilMetro{$i}:=1
		End for 
		
		// Gare
		For ($i; 1; Size of array:C274(<>ta_VeilGare))
			<>te_VeilGare{$i}:=1
		End for 
		
		// Plateforme
		For ($i; 1; Size of array:C274(<>te_VeilPlateforme))
			<>te_VeilPlateforme{$i}:=1
		End for 
		
		// Dossier SIAO
		For ($i; 1; Size of array:C274(<>te_VeilDosSIAO))
			<>te_VeilDosSIAO{$i}:=1
		End for 
		
		// FamCasSpec
		For ($i; 1; Size of array:C274(<>te_VeilFMCaS))
			<>te_VeilFMCaS{$i}:=1
		End for 
		
End case 