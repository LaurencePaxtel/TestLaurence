//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutDécTableCritère
//{
//{          Lundi 28 décembre 2009 à 10:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//••• TABLEAU •••
C_LONGINT:C283($1)

C_LONGINT:C283($ii)

Case of 
	: ($1=0)
		//Etat civil
		ARRAY TEXT:C222(ta_CritEtCiv; 0)
		ARRAY INTEGER:C220(te_CritEtCiv; 0)
		
		//Signalement
		ARRAY TEXT:C222(ta_CritSglt; 0)
		ARRAY INTEGER:C220(te_CritSglt; 0)
		
		//groupes
		ARRAY TEXT:C222(ta_CritGroupe; 0)
		ARRAY INTEGER:C220(te_CritGroupe; 0)
		
		//perma
		ARRAY TEXT:C222(ta_CritPerma; 0)
		ARRAY INTEGER:C220(te_CritPerma; 0)
		
		//Autres solutions 
		ARRAY TEXT:C222(ta_CritAutreSol; 0)
		ARRAY INTEGER:C220(te_CritAutreSol; 0)
		
		//Orientation1
		ARRAY TEXT:C222(ta_CritOrient1; 0)
		ARRAY INTEGER:C220(te_CritOrient1; 0)
		
		//Orientation2
		ARRAY TEXT:C222(ta_CritOrient2; 0)
		ARRAY INTEGER:C220(te_CritOrient2; 0)
		
		
		ARRAY TEXT:C222(ta_CritRupMaj1; 0)
		ARRAY INTEGER:C220(te_CritRupMaj1; 0)
		
		ARRAY TEXT:C222(ta_CritRupMaj2; 0)
		ARRAY INTEGER:C220(te_CritRupMaj2; 0)
		
		ARRAY TEXT:C222(ta_CritRupMaj3; 0)
		ARRAY INTEGER:C220(te_CritRupMaj3; 0)
		
		ARRAY TEXT:C222(ta_Critidt1; 0)
		ARRAY INTEGER:C220(te_Critidt1; 0)
		
		ARRAY TEXT:C222(ta_Critidt2; 0)
		ARRAY INTEGER:C220(te_Critidt2; 0)
		
		ARRAY TEXT:C222(ta_Critidt3; 0)
		ARRAY INTEGER:C220(te_Critidt3; 0)
		
		ARRAY TEXT:C222(ta_CritDistri5; 0)
		ARRAY INTEGER:C220(te_CritDistri5; 0)
		
		//Ressources 
		ARRAY TEXT:C222(ta_CritRess1; 0)
		ARRAY INTEGER:C220(te_CritRess1; 0)
		
		ARRAY TEXT:C222(ta_CritRess2; 0)
		ARRAY INTEGER:C220(te_CritRess2; 0)
		
		ARRAY TEXT:C222(ta_CritRess3; 0)
		ARRAY INTEGER:C220(te_CritRess3; 0)
		
		//Suivi social 
		ARRAY TEXT:C222(ta_CritSSoc1; 0)
		ARRAY INTEGER:C220(te_CritSSoc1; 0)
		
		ARRAY TEXT:C222(ta_CritSSoc2; 0)
		ARRAY INTEGER:C220(te_CritSSoc2; 0)
		
		ARRAY TEXT:C222(ta_CritSSoc3; 0)
		ARRAY INTEGER:C220(te_CritSSoc3; 0)
		
		//Couverture social
		ARRAY TEXT:C222(ta_CritCSoc1; 0)
		ARRAY INTEGER:C220(te_CritCSoc1; 0)
		
		ARRAY TEXT:C222(ta_CritCSoc2; 0)
		ARRAY INTEGER:C220(te_CritCSoc2; 0)
		
		ARRAY TEXT:C222(ta_CritCSoc3; 0)
		ARRAY INTEGER:C220(te_CritCSoc3; 0)
		
		ARRAY TEXT:C222(ta_CritNivEt; 0)
		ARRAY INTEGER:C220(te_CritNivEt; 0)
		
		ARRAY TEXT:C222(ta_CritTpsEr; 0)
		ARRAY INTEGER:C220(te_CritTpsEr; 0)
		
		ARRAY TEXT:C222(ta_CritMetro; 0)
		ARRAY INTEGER:C220(te_CritMetro; 0)
		
		ARRAY TEXT:C222(ta_CritGare; 0)
		ARRAY INTEGER:C220(te_CritGare; 0)
		
		ARRAY TEXT:C222(ta_CritPlateforme; 0)
		ARRAY INTEGER:C220(te_CritPlateforme; 0)
		
		ARRAY TEXT:C222(ta_CritCasSpe; 0)
		ARRAY INTEGER:C220(te_CritCasSpe; 0)
	: ($1=1)
		
		// Etat civil    
		COPY ARRAY:C226(<>ta_TBEtCiv; ta_CritEtCiv)
		i_TableauInitEntier(1; ->ta_CritEtCiv; ->te_CritEtCiv)
		
		// Signalement
		COPY ARRAY:C226(<>ta_TBSglt; ta_CritSglt)
		i_TableauInitEntier(1; ->ta_CritSglt; ->te_CritSglt)
		
		// Groupes
		COPY ARRAY:C226(<>ta_FMGrpX; ta_CritGroupe)
		COPY ARRAY:C226(<>te_FMGrpCK; te_CritGroupe)
		
		// Permanancier
		COPY ARRAY:C226(<>ta_InPerm; ta_CritPerma)
		COPY ARRAY:C226(<>te_InPermCK; te_CritPerma)
		
		// Autres solutions
		COPY ARRAY:C226(<>ta_AtS; ta_CritAutreSol)
		i_TableauInitEntier(1; ->ta_CritAutreSol; ->te_CritAutreSol)
		
		// Orientation1
		COPY ARRAY:C226(<>ta_TBOr1; ta_CritOrient1)
		i_TableauInitEntier(1; ->ta_CritOrient1; ->te_CritOrient1)
		
		// Orientation2
		COPY ARRAY:C226(<>ta_TBOr2; ta_CritOrient2)
		i_TableauInitEntier(1; ->ta_CritOrient2; ->te_CritOrient2)
		
		//Ruptures majeures
		COPY ARRAY:C226(<>ta_TBRupMaj; ta_CritRupMaj1)
		i_TableauInitEntier(1; ->ta_CritRupMaj1; ->te_CritRupMaj1)
		
		COPY ARRAY:C226(<>ta_TBRupMaj2; ta_CritRupMaj2)
		i_TableauInitEntier(1; ->ta_CritRupMaj2; ->te_CritRupMaj2)
		
		COPY ARRAY:C226(<>ta_TBRupMaj3; ta_CritRupMaj3)
		i_TableauInitEntier(1; ->ta_CritRupMaj3; ->te_CritRupMaj3)
		
		COPY ARRAY:C226(<>ta_TBPIdté; ta_Critidt1)
		i_TableauInitEntier(1; ->ta_Critidt1; ->te_Critidt1)
		
		COPY ARRAY:C226(<>ta_TBPIdté2; ta_Critidt2)
		i_TableauInitEntier(1; ->ta_Critidt2; ->te_Critidt2)
		
		COPY ARRAY:C226(<>ta_TBPIdté3; ta_Critidt3)
		i_TableauInitEntier(1; ->ta_Critidt3; ->te_Critidt3)
		
		COPY ARRAY:C226(<>ta_FMDis5; ta_CritDistri5)
		i_TableauInitEntier(1; ->ta_CritDistri5; ->te_CritDistri5)
		
		// Ressources 
		COPY ARRAY:C226(<>ta_TBResAct; ta_CritRess1)
		i_TableauInitEntier(1; ->ta_CritRess1; ->te_CritRess1)
		
		COPY ARRAY:C226(<>ta_TBResAct; ta_CritRess2)
		i_TableauInitEntier(1; ->ta_CritRess2; ->te_CritRess2)
		
		COPY ARRAY:C226(<>ta_TBResAct; ta_CritRess3)
		i_TableauInitEntier(1; ->ta_CritRess3; ->te_CritRess3)
		
		// Suivi social
		COPY ARRAY:C226(<>ta_TBSuiSoc; ta_CritSSoc1)
		i_TableauInitEntier(1; ->ta_CritSSoc1; ->te_CritSSoc1)
		
		COPY ARRAY:C226(<>ta_TBSuiSoc; ta_CritSSoc2)
		i_TableauInitEntier(1; ->ta_CritSSoc2; ->te_CritSSoc2)
		
		COPY ARRAY:C226(<>ta_TBSuiSoc; ta_CritSSoc3)
		i_TableauInitEntier(1; ->ta_CritSSoc3; ->te_CritSSoc3)
		
		// Couverture social
		COPY ARRAY:C226(<>ta_TBCouSoc; ta_CritCSoc1)
		i_TableauInitEntier(1; ->ta_CritCSoc1; ->te_CritCSoc1)
		
		COPY ARRAY:C226(<>ta_TBCouSoc; ta_CritCSoc2)
		i_TableauInitEntier(1; ->ta_CritCSoc2; ->te_CritCSoc2)
		
		COPY ARRAY:C226(<>ta_TBCouSoc; ta_CritCSoc3)
		i_TableauInitEntier(1; ->ta_CritCSoc3; ->te_CritCSoc3)
		
		// Niveau d'étude
		COPY ARRAY:C226(<>ta_TBNivEtu; ta_CritNivEt)
		i_TableauInitEntier(1; ->ta_CritNivEt; ->te_CritNivEt)
		
		// Temps d'errance
		COPY ARRAY:C226(<>ta_TBTpsErr; ta_CritTpsEr)
		i_TableauInitEntier(1; ->ta_CritTpsEr; ->te_CritTpsEr)
		
		// Metro
		COPY ARRAY:C226(<>ta_TBMetro; ta_CritMetro)
		i_TableauInitEntier(1; ->ta_CritMetro; ->te_CritMetro)
		
		// Gare
		COPY ARRAY:C226(<>ta_TBGare; ta_CritGare)
		i_TableauInitEntier(1; ->ta_CritGare; ->te_CritGare)
		
		// Plateforme
		COPY ARRAY:C226(<>ta_Plateforme; ta_CritPlateforme)
		i_TableauInitEntier(1; ->ta_CritPlateforme; ->te_CritPlateforme)
	: ($1=2)
		ARRAY TEXT:C222(ta_xCritères; 28)
		ARRAY INTEGER:C220(te_xCritères; Size of array:C274(ta_xCritères))
		
		For ($ii; 1; Size of array:C274(ta_xCritères))
			te_xCritères{$ii}:=0
		End for 
		
		ta_xCritères{1}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{40}
		ta_xCritères{2}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}
		ta_xCritères{3}:="Permanencier"
		ta_xCritères{4}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}
		ta_xCritères{5}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}
		ta_xCritères{6}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{48}
		ta_xCritères{7}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{49}
		ta_xCritères{8}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28}
		ta_xCritères{9}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{29}
		ta_xCritères{10}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{30}
		
		ta_xCritères{11}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25}
		ta_xCritères{12}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{26}
		ta_xCritères{13}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{27}
		ta_xCritères{14}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{82}
		
		ta_xCritères{15}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{31}
		ta_xCritères{16}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{32}
		ta_xCritères{17}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{33}
		
		ta_xCritères{18}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{34}
		ta_xCritères{19}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{35}
		ta_xCritères{20}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{36}
		
		ta_xCritères{21}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{37}
		ta_xCritères{22}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{38}
		ta_xCritères{23}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{39}
		
		ta_xCritères{24}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{41}
		ta_xCritères{25}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{14}
		ta_xCritères{26}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9}
		ta_xCritères{27}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{8}
		ta_xCritères{28}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{100}
		
		ta_xCritères:=1
		ta_xCritères{0}:=ta_xCritères{ta_xCritères}
	: ($1=3)
		
		If (Size of array:C274(ta_xCritères)>0)
			
			If (ta_xCritères>0)
				
				Case of 
					: (ta_xCritères=1)  //Etat civil
						P_HébergementCritères(->ta_CritEtCiv; ->te_CritEtCiv; ta_xCritères{ta_xCritères})
					: (ta_xCritères=2)  //Groupe
						P_HébergementCritères(->ta_CritGroupe; ->te_CritGroupe; ta_xCritères{ta_xCritères})
					: (ta_xCritères=3)  //Permanent
						
						If (<>vb_UserLOFT)
							StrAlerte(6; "Permanencier")
							ta_xCritères:=Find in array:C230(ta_xCritères; ta_xCritères{0})
						Else 
							P_HébergementCritères(->ta_CritPerma; ->te_CritPerma; ta_xCritères{ta_xCritères})
						End if 
						
					: (ta_xCritères=4)  //Signalement
						P_HébergementCritères(->ta_CritSglt; ->te_CritSglt; ta_xCritères{ta_xCritères})
					: (ta_xCritères=5)  //Autre solution
						P_HébergementCritères(->ta_CritAutreSol; ->te_CritAutreSol; ta_xCritères{ta_xCritères})
					: (ta_xCritères=6)  //Orientation1
						P_HébergementCritères(->ta_CritOrient1; ->te_CritOrient1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=7)  //Orientation2
						P_HébergementCritères(->ta_CritOrient2; ->te_CritOrient2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=8)  //Ruptures majeures
						P_HébergementCritères(->ta_CritRupMaj1; ->te_CritRupMaj1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=9)  //Ruptures majeures
						P_HébergementCritères(->ta_CritRupMaj2; ->te_CritRupMaj2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=10)  //Ruptures majeures
						P_HébergementCritères(->ta_CritRupMaj3; ->te_CritRupMaj3; ta_xCritères{ta_xCritères})
					: (ta_xCritères=11)  //Identité 1
						P_HébergementCritères(->ta_Critidt1; ->te_Critidt1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=12)  //Identité 2
						P_HébergementCritères(->ta_Critidt2; ->te_Critidt2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=13)  //Identité 3
						P_HébergementCritères(->ta_Critidt3; ->te_Critidt2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=14)  //Distribution 5
						P_HébergementCritères(->ta_CritDistri5; ->te_CritDistri5; ta_xCritères{ta_xCritères})
					: (ta_xCritères=15)  //Ressources
						P_HébergementCritères(->ta_CritRess1; ->te_CritRess1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=16)  //Ressources
						P_HébergementCritères(->ta_CritRess2; ->te_CritRess2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=17)  //Ressources
						P_HébergementCritères(->ta_CritRess3; ->te_CritRess3; ta_xCritères{ta_xCritères})
					: (ta_xCritères=18)  //Suivi social
						P_HébergementCritères(->ta_CritSSoc1; ->te_CritSSoc1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=19)  //Suivi social
						P_HébergementCritères(->ta_CritSSoc2; ->te_CritSSoc2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=20)  //Suivi social
						P_HébergementCritères(->ta_CritSSoc3; ->te_CritSSoc3; ta_xCritères{ta_xCritères})
					: (ta_xCritères=21)  //Couverture sociale
						P_HébergementCritères(->ta_CritCSoc1; ->te_CritCSoc1; ta_xCritères{ta_xCritères})
					: (ta_xCritères=22)  //Couverture sociale
						P_HébergementCritères(->ta_CritCSoc2; ->te_CritCSoc2; ta_xCritères{ta_xCritères})
					: (ta_xCritères=23)  //Couverture sociale
						P_HébergementCritères(->ta_CritCSoc3; ->te_CritCSoc3; ta_xCritères{ta_xCritères})
					: (ta_xCritères=24)  //Niveau d'étude
						P_HébergementCritères(->ta_CritNivEt; ->te_CritNivEt; ta_xCritères{ta_xCritères})
					: (ta_xCritères=25)  //Temps d'errance
						P_HébergementCritères(->ta_CritTpsEr; ->te_CritTpsEr; ta_xCritères{ta_xCritères})
					: (ta_xCritères=26)  //Metro
						P_HébergementCritères(->ta_CritMetro; ->te_CritMetro; ta_xCritères{ta_xCritères})
					: (ta_xCritères=27)  //Gare
						P_HébergementCritères(->ta_CritGare; ->te_CritGare; ta_xCritères{ta_xCritères})
					: (ta_xCritères=28)  //Plateforme
						P_HébergementCritères(->ta_CritPlateforme; ->te_CritPlateforme; ta_xCritères{ta_xCritères})
				End case 
				
				ta_xCritères{0}:=ta_xCritères{ta_xCritères}
			End if 
			
		End if 
		
End case 