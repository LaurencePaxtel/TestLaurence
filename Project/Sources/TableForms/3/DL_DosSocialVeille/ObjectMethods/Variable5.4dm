If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_xCritères)>0)
		If (ta_xCritères>0)
			
			
			$vl_Fenetre:=0
			Case of 
				: (ta_xCritères=1)  //Etat civil
					P_HébergementCritères(-><>ta_DsEtCiv; -><>te_DsEtCiv; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=2)  //Nationalité
					P_HébergementCritères(-><>ta_DsNat; -><>te_DsNat; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=3)  //PersMaj
					P_HébergementCritères(-><>ta_DsPmaj; -><>te_DsPmaj; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=4)  //ConnuSSP_Motif
					P_HébergementCritères(-><>ta_DsCoSSP; -><>te_DsCoSSP; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=5)  //Compagnie_Problèmatique
					P_HébergementCritères(-><>ta_DsComp; -><>te_DsComp; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=6)  //Régime1
					P_HébergementCritères(-><>ta_DsRgim1; -><>te_DsRgim1; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=7)  //Papier1
					P_HébergementCritères(-><>ta_DsPap1; -><>te_DsPap1; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=8)  //Soc1
					P_HébergementCritères(-><>ta_DsSoc1; -><>te_DsSoc1; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=9)  //Res1
					P_HébergementCritères(-><>ta_DsRes1; -><>te_DsRes1; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=10)  //Err
					P_HébergementCritères(-><>ta_DsErr; -><>te_DsErr; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=11)  //NeOu
					P_HébergementCritères(-><>ta_DsNeOu; -><>te_DsNeOu; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=12)  //Langue
					P_HébergementCritères(-><>ta_DsLang; -><>te_DsLang; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=13)  //DerHéberg
					P_HébergementCritères(-><>ta_DsDerH; -><>te_DsDerH; ta_xCritères{ta_xCritères})
					
				: (ta_xCritères=14)  //CouvSoc
					P_HébergementCritères(-><>ta_DsCouvS; -><>te_DsCouvS; ta_xCritères{ta_xCritères})
					
			End case 
			ta_xCritères{0}:=ta_xCritères{ta_xCritères}
			
		End if 
	End if 
End if 