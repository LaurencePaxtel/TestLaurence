If (Form event code:C388=Sur clic:K2:4)
	
	C_LONGINT:C283($L_Size)
	$L_Size:=Size of array:C274(ta_xCritères)
	
	C_LONGINT:C283($i)
	$i:=ta_xCritères
	
	C_POINTER:C301($P_Tableau_cible_A; $P_Tableau_cible_E)
	Case of 
		: ($i=1)  // Etat civil
			$P_Tableau_cible_A:=-><>ta_SIAOREC_EtCv
			$P_Tableau_cible_E:=-><>te_SIAOREC_EtCv
		: ($i=2)  // Référent
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Referent
			$P_Tableau_cible_E:=-><>te_SIAOREC_Referent
		: ($i=3)  // Statut de la demande
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Statut
			$P_Tableau_cible_E:=-><>te_SIAOREC_Statut
		: ($i=4)  // SIAO compétent
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Competent
			$P_Tableau_cible_E:=-><>te_SIAOREC_Competent
		: ($i=5)  // Site accueil
			$P_Tableau_cible_A:=-><>ta_SIAOREC_SitAccueil
			$P_Tableau_cible_E:=-><>te_SIAOREC_SitAccueil
		: ($i=6)  // Lieu d’origine
			$P_Tableau_cible_A:=-><>ta_SIAOREC_NeLeLieu
			$P_Tableau_cible_E:=-><>te_SIAOREC_NeLeLieu
		: ($i=7)  // Nationalité
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Nationalite
			$P_Tableau_cible_E:=-><>te_SIAOREC_Nationalite
		: ($i=8)  // cas spécifique
			$P_Tableau_cible_A:=-><>ta_SIAOREC_CasSpec
			$P_Tableau_cible_E:=-><>te_SIAOREC_CasSpec
		: ($i=9)  // Logement souhaité 1, 2, 3
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter1
			$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter1
		: ($i=10)
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter2
			$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter2
		: ($i=11)
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter3
			$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter3
		: ($i=12)  // Logement adapté
			$P_Tableau_cible_A:=-><>ta_SIAOREC_LogAdapte
			$P_Tableau_cible_E:=-><>te_SIAOREC_LogAdapte
		: ($i=13)  // Type d’accompagnement souhaite 1, 2, 3
			$P_Tableau_cible_A:=-><>ta_SIAOREC_TypeAccS1
			$P_Tableau_cible_E:=-><>te_SIAOREC_TypeAccS1
		: ($i=14)
			$P_Tableau_cible_A:=-><>ta_SIAOREC_TypeAccS2
			$P_Tableau_cible_E:=-><>te_SIAOREC_TypeAccS2
		: ($i=15)
			$P_Tableau_cible_A:=-><>ta_SIAOREC_TypeAccS3
			$P_Tableau_cible_E:=-><>te_SIAOREC_TypeAccS3
		: ($i=16)
			$P_Tableau_cible_A:=-><>ta_SIAOREC_SitProf1
			$P_Tableau_cible_E:=-><>te_SIAOREC_SitProf1
		: ($i=17)
			$P_Tableau_cible_A:=-><>ta_SIAOREC_SitProf2
			$P_Tableau_cible_E:=-><>te_SIAOREC_SitProf2
		: ($i=18)  // Sans situation professionnel
			$P_Tableau_cible_A:=-><>ta_SIAOREC_SanSitProf
			$P_Tableau_cible_E:=-><>te_SIAOREC_SanSitProf
		: ($i=19)  // Moyen de locomotion
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Locomotion
			$P_Tableau_cible_E:=-><>te_SIAOREC_Locomotion
		: ($i=20)  // Ressources 1
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Ressource
			$P_Tableau_cible_E:=-><>te_SIAOREC_Ressource
		: ($i=21)  // Logement ou hébergement actuel 1
			$P_Tableau_cible_A:=-><>ta_SIAOREC_LogActuel
			$P_Tableau_cible_E:=-><>te_SIAOREC_LogActuel
		: ($i=22)
			$P_Tableau_cible_A:=-><>ta_SIAOREC_MotifDem1
			$P_Tableau_cible_E:=-><>te_SIAOREC_MotifDem1
		: ($i=23)  // Motif de la demande 1
			$P_Tableau_cible_A:=-><>ta_SIAOREC_MotifDem2
			$P_Tableau_cible_E:=-><>te_SIAOREC_MotifDem2
		: ($i=24)  // Proposition d’orientation du SIAO 1 2 3
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter_SIAO1
			$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter_SIAO1
		: ($i=25)
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter_SIAO2
			$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter_SIAO2
		: ($i=26)
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter_SIAO3
			$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter_SIAO3
		Else 
			TRACE:C157
	End case 
	ta_xCritères{0}:=ta_xCritères{ta_xCritères}
	
	P_HébergementCritères($P_Tableau_cible_A; $P_Tableau_cible_E; ta_xCritères{ta_xCritères})
	
	
	
	
	If (1=2)
		// remplacé par le code ci-dessus
		If (Size of array:C274(ta_xCritères)>0)
			
			
			If (ta_xCritères>0)
				
				
				//$vl_Fenetre:=0
				Case of 
					: (ta_xCritères=1)  //Etat civil
						P_HébergementCritères(-><>ta_SIAOREC_EtCv; -><>te_SIAOREC_EtCv; ta_xCritères{ta_xCritères})
					: (ta_xCritères=2)  //référent
						P_HébergementCritères(-><>ta_SIAOREC_Referent; -><>te_SIAOREC_Referent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=3)  //Statut de la demande
						P_HébergementCritères(-><>ta_SIAOREC_Statut; -><>te_SIAOREC_Statut; ta_xCritères{ta_xCritères})
					: (ta_xCritères=4)  //SIAO compétent
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=5)  //Site d'accueil
						P_HébergementCritères80(-><>ta_SIAOREC_SitAccueil; -><>te_SIAOREC_SitAccueil; ta_xCritères{ta_xCritères})
						
						// ajouté 21/12/16
					: (ta_xCritères=6)  //   "Lieu d’origine"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=7)  //   "Nationalité"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=8)  //   "Cas spécifique"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=9)  //   "Logement souhaité 1"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=10)  //   "Logement souhaité 2"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=11)  //   "Logement souhaité 3"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=12)  //   "Logement adapté"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=13)  //   "Type d’accompagnement souhaite 1"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=14)  //   "Type d’accompagnement souhaite 2"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=15)  //   "Type d’accompagnement souhaite 3"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=16)  //   "Situation professionnelle 1"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=17)  //   "Situation professionnelle 2"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=18)  //   "Sans situation professionnelle"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=19)  //   "Moyen de locomotion"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=20)  //   "Ressources 1"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=21)  //   "Logement ou hébergement actuel 1"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=22)  //   "Motif de la demande 1"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=23)  //   "Motif de la demande 2"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=24)  //   "Proposition d’orientation du SIAO 1"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=25)  //   "Proposition d’orientation du SIAO 2"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
					: (ta_xCritères=26)  //   "Proposition d’orientation du SIAO 3"
						P_HébergementCritères(-><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent; ta_xCritères{ta_xCritères})
						
						
						
						
					: (ta_xCritères=105)  //Logement actuel
						// ça je vois pas ce que c'est 21/12/16
						P_HébergementCritères(-><>ta_SIAOREC_LogAct; -><>te_SIAOREC_LogAct; ta_xCritères{ta_xCritères})
				End case 
				ta_xCritères{0}:=ta_xCritères{ta_xCritères}
				
			End if 
		End if 
	End if 
	
End if 