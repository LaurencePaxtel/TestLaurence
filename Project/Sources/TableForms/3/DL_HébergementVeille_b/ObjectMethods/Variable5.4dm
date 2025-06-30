If (Form event code:C388=Sur clic:K2:4)
	
	If (Size of array:C274(ta_xCritères)>0)
		
		If (ta_xCritères>0)
			
			// Modifié par : Scanu Rémy - remy@connect-io.fr (13/04/2022)
			Case of 
				: (ta_xCritères=1)  // Etat civil
					P_HébergementCritères(-><>ta_VeilEtCiv; -><>te_VeilEtCiv; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=2)  // Groupe
					P_HébergementCritères(-><>ta_VeilGroupe; -><>te_VeilGroupe; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=3)  // Permanent
					
					If (<>vb_UserLOFT)
						StrAlerte(6; "Permanencier")
						
						ta_xCritères:=Find in array:C230(ta_xCritères; ta_xCritères{0})
					Else 
						P_HébergementCritères(-><>ta_VeilPerma; -><>te_VeilPerma; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
					End if 
					
				: (ta_xCritères=4)  // Signalement
					P_HébergementCritères(-><>ta_VeilSglt; -><>te_VeilSglt; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=5)  // Autre solution
					P_HébergementCritères(-><>ta_VeilAutreSol; -><>te_VeilAutreSol; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=6)  // Orientation1
					P_HébergementCritères(-><>ta_VeilOrient1; -><>te_VeilOrient1; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=7)  // Orientation 1 suite
					P_HébergementCritères(-><>ta_VeilTBOr1suite; -><>te_VeilTBOr1suite; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))  // 17/2/17
				: (ta_xCritères=8)  // Autre solution suite
					P_HébergementCritères(-><>ta_VeilAtSsuite; -><>te_VeilAtSsuite; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))  //17/2/17
				: (ta_xCritères=9)  // Orientation2
					P_HébergementCritères(-><>ta_VeilOrient2; -><>te_VeilOrient2; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=10)  // Ruptures majeures
					P_HébergementCritères(-><>ta_VeilRupMaj1; -><>te_VeilRupMaj1; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=11)  // Ruptures majeures
					P_HébergementCritères(-><>ta_VeilRupMaj2; -><>te_VeilRupMaj2; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=12)  // Ruptures majeures
					P_HébergementCritères(-><>ta_VeilRupMaj3; -><>te_VeilRupMaj3; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=13)  // Identité 1
					P_HébergementCritères(-><>ta_Veilidt1; -><>te_Veilidt1; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=14)  // Identité 2
					P_HébergementCritères(-><>ta_Veilidt2; -><>te_Veilidt2; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=15)  // Identité 3
					P_HébergementCritères(-><>ta_Veilidt3; -><>te_Veilidt2; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=16)  // Distribution 5
					P_HébergementCritères(-><>ta_VeilDistri5; -><>te_VeilDistri5; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=17)  // Ressources 1
					P_HébergementCritères(-><>ta_VeilRess1; -><>te_VeilRess1; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=18)  // Ressources 2
					P_HébergementCritères(-><>ta_VeilRess2; -><>te_VeilRess2; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=19)  // Ressources 3
					P_HébergementCritères(-><>ta_VeilRess3; -><>te_VeilRess3; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=20)  // Suivi social 1
					P_HébergementCritères(-><>ta_VeilSSoc1; -><>te_VeilSSoc1; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=21)  // Suivi social 2
					P_HébergementCritères(-><>ta_VeilSSoc2; -><>te_VeilSSoc2; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=22)  // Suivi social 3
					P_HébergementCritères(-><>ta_VeilSSoc3; -><>te_VeilSSoc3; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=23)  // Couverture sociale 1
					P_HébergementCritères(-><>ta_VeilCSoc1; -><>te_VeilCSoc1; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=24)  // Couverture sociale 2
					P_HébergementCritères(-><>ta_VeilCSoc2; -><>te_VeilCSoc2; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=25)  // Couverture sociale 3
					P_HébergementCritères(-><>ta_VeilCSoc3; -><>te_VeilCSoc3; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=26)  // Niveau d'étude
					P_HébergementCritères(-><>ta_VeilNivEt; -><>te_VeilNivEt; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=27)  // Temps d'errance
					P_HébergementCritères(-><>ta_VeilTpsEr; -><>te_VeilTpsEr; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=28)  // Metro
					P_HébergementCritères(-><>ta_VeilMetro; -><>te_VeilMetro; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=29)  // Gare
					P_HébergementCritères(-><>ta_VeilGare; -><>te_VeilGare; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=30)  // Plateforme
					P_HébergementCritères(-><>ta_VeilPlateforme; -><>te_VeilPlateforme; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=31)  // Dossier SIAO
					P_HébergementCritères(-><>ta_VeilDosSIAO; -><>te_VeilDosSIAO; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=32)  // Centre
					P_HébergementCritCentre
				: (ta_xCritères=33)  // FamCasSpec
					P_HébergementCritères(-><>ta_VeilFMCaS; -><>te_VeilFMCaS; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=34)  // Régulateur
					P_HébergementCritères(-><>ta_VeilRegulateur; -><>te_VeilRegulateur; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=35)  // Réservation provisoire
					P_HébergementCritères(-><>ta_ReservationProvisoire; -><>te_ReservationProvisoire; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=36)  // Nationalité
					P_HébergementCritères(-><>ta_Nationalite; -><>te_Nationalite; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=37)  // Assistante sociale
					P_HébergementCritères(-><>ta_AssistanteSociale; -><>te_AssistanteSociale; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=38)  // Code postal
					P_HébergementCritères(-><>ta_CodePostal; -><>te_CodePostal; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=39)  // Coordinateur
					P_HébergementCritères(-><>ta_Coordinateur; -><>te_Coordinateur; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=40)  // Dernier emploi
					P_HébergementCritères(-><>ta_DernierEmploi; -><>te_DernierEmploi; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=41)  // Dernier hébergement
					P_HébergementCritères(-><>ta_DernierHebergement; -><>te_DernierHebergement; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=42)  // Durée sans emploi
					P_HébergementCritères(-><>ta_DureeSansEmploi; -><>te_DureeSansEmploi; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=43)  // Genre
					P_HébergementCritères(-><>ta_Genre; -><>te_Genre; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=44)  // Lien
					P_HébergementCritères(-><>ta_Lien; -><>te_Lien; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=45)  // Nationalité
					P_HébergementCritères(-><>ta_SituationFamille; -><>te_SituationFamille; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=46)  // Situation professionnelle
					P_HébergementCritères(-><>ta_SituationProf; -><>te_SituationProf; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
				: (ta_xCritères=47)  // Emplacement
					P_HébergementCritères(-><>ta_Emplacement; -><>te_Emplacement; ta_xCritères{ta_xCritères}; New collection:C1472(New object:C1471("label"; "(Sans valeur)"; "select"; 1)))
			End case 
			
			ta_xCritères{0}:=ta_xCritères{ta_xCritères}
		End if 
		
	End if 
	
End if 