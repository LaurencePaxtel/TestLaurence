//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_TauxOccupation
//{
//{          Mercredi 21 janvier 2009 à 15:18
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($ii; $jj; $kk)
C_TIME:C306($vh_Dummy; $vh_Dummy2)
C_BOOLEAN:C305($vb_OK; $vb_115)
C_LONGINT:C283($vl_Position1; $vl_Position2)

C_TEXT:C284($va_Comparer)

Case of 
	: ($1=0)
	: ($1=1)
		
		If (<>vb_T_OccupMinuteurMess)
			i_Message("Taux d'occupation…")
		End if 
		
		P_OccupationTab(0)
		
		If (<>vb_T_OccupMinuteurMess)
			i_MessageSeul("Taux d'occupation : recherche")
		End if 
		
		//ESt-ce un 115 ou un CHRS
		//115 : numérotation des centres entre 0 et 999 999
		//Les autres sont à partir de 1 000 000
		$vb_115:=(<>ve_T_CentreCode=0)
		
		$vb_OK:=False:C215
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=False:C215; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Fermé:53=False:C215)
		MultiSoc_Filter(->[LesCentres:9])
		If (Records in selection:C76([LesCentres:9])>0)
			$vb_OK:=True:C214
			
			ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Répertoire:54; >; *)
			ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
			FIRST RECORD:C50([LesCentres:9])
			SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; <>tl_Occ_CentreRéférence; [LesCentres:9]LC_Code:3; <>ta_Occ_CentreCode; [LesCentres:9]LC_Répertoire:54; <>ta_Occ_CentreRepertoire; [LesCentres:9]LC_Plateforme:56; <>ta_Occ_CentrePlateforme; [LesCentres:9]LC_Nom:4; <>ta_Occ_CentreNom; [LesCentres:9]LC_DispoJour:48; <>tl_Occ_CentreCapacité)
			P_OccupationTab(1)
			For ($ii; 1; Size of array:C274(<>tl_Occ_CentreRéférence))
				<>tl_Occ_CentreRéfPère{$ii}:=0
				<>ta_Occ_CentreNomPère{$ii}:=""
				<>te_Occ_CentreNbFils{$ii}:=0
				<>tb_Occ_CentreEtat{$ii}:=False:C215
				<>tl_Occ_CentreUtilisé{$ii}:=0
				<>tl_Occ_CentreUtiliséH{$ii}:=0
				<>tl_Occ_CentreUtiliséF{$ii}:=0
				<>tl_Occ_CentreUtiliséM{$ii}:=0
				<>tl_Occ_CentreReste{$ii}:=0
				<>tr_Occ_CentreTaux{$ii}:=0
			End for 
		End if 
		
		If ($vb_OK)
			For ($ii; 1; Size of array:C274(<>tl_Occ_CentreRéférence))
				
				If (<>vb_T_OccupMinuteurMess)
					i_MessageSeul("Taux d'occupation : recherche : "+String:C10($ii)+"/"+String:C10(Size of array:C274(<>tl_Occ_CentreRéférence)))
				End if 
				
				ARRAY LONGINT:C221(<>tl_Occ_CentreLiés; 0)
				<>te_Occ_CentreNbFils{$ii}:=0
				If ($vb_115)
					If (<>ta_Occ_CentreRepertoire{$ii}="115")
						$jj:=Size of array:C274(<>tl_Occ_CentreLiés)+1
						INSERT IN ARRAY:C227(<>tl_Occ_CentreLiés; $jj)
						<>tl_Occ_CentreLiés{$jj}:=<>tl_Occ_CentreRéférence{$ii}
					Else 
						If (<>ta_Occ_CentreRepertoire{$ii}>"")
							QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54=<>ta_Occ_CentreRepertoire{$ii})
							MultiSoc_Filter(->[LesCentres:9])
							QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1#<>tl_Occ_CentreRéférence{$ii})
							If (Records in selection:C76([LesCentres:9])>0)
								SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; <>tl_Occ_CentreLiés)
								<>te_Occ_CentreNbFils{$ii}:=Size of array:C274(<>tl_Occ_CentreLiés)
							End if 
						End if 
					End if 
				Else   //Ce n'est pas le 115
					$jj:=Size of array:C274(<>tl_Occ_CentreLiés)+1
					INSERT IN ARRAY:C227(<>tl_Occ_CentreLiés; $jj)
					<>tl_Occ_CentreLiés{$jj}:=<>tl_Occ_CentreRéférence{$ii}
				End if 
				
				//Calcul du nombre de lits occupés ou des hébergements
				If (Size of array:C274(<>tl_Occ_CentreLiés)>0)
					<>tl_Occ_CentreUtilisé{$ii}:=0
					For ($jj; 1; Size of array:C274(<>tl_Occ_CentreLiés))
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=<>tl_Occ_CentreLiés{$jj}; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
						MultiSoc_Filter(->[HeberGement:5])
						<>tl_Occ_CentreUtilisé{$ii}:=<>tl_Occ_CentreUtilisé{$ii}+Records in selection:C76([HeberGement:5])
						If (<>tl_Occ_CentreUtilisé{$ii}>0)
							SELECTION TO ARRAY:C260([HeberGement:5]HG_EtatCivil:20; <>tl_Occ_EtatCivil)
							For ($kk; 1; Size of array:C274(<>tl_Occ_EtatCivil))
								
								
								
								$vl_Position1:=Position:C15("("; <>tl_Occ_EtatCivil{$kk})
								$vl_Position2:=Position:C15(")"; <>tl_Occ_EtatCivil{$kk})
								$vb_OK:=($vl_Position1>0)
								$vb_OK:=$vb_OK & ($vl_Position2>0)
								If ($vb_OK)
									If (<>tl_Occ_EtatCivil{$kk}[[($vl_Position2-1)]]="P")
										<>tl_Occ_CentreUtiliséM{$ii}:=<>tl_Occ_CentreUtiliséM{$ii}+1
									Else 
										If (<>tl_Occ_EtatCivil{$kk}[[($vl_Position1+1)]]="F")
											<>tl_Occ_CentreUtiliséF{$ii}:=<>tl_Occ_CentreUtiliséF{$ii}+1
										Else 
											<>tl_Occ_CentreUtiliséH{$ii}:=<>tl_Occ_CentreUtiliséH{$ii}+1
										End if 
									End if 
								End if 
								
								
								
							End for 
						End if 
					End for 
				End if 
				
				//Calcul du taux d'occupation
				If (<>tl_Occ_CentreCapacité{$ii}>0)
					<>tl_Occ_CentreReste{$ii}:=<>tl_Occ_CentreCapacité{$ii}-<>tl_Occ_CentreUtilisé{$ii}
					<>tr_Occ_CentreTaux{$ii}:=Round:C94(((<>tl_Occ_CentreUtilisé{$ii}/<>tl_Occ_CentreCapacité{$ii})*100); 2)
				End if 
			End for 
			
			//Option d'affichage : que les centres où il y a des lits occupés
			If (vl_Rafraichir=1)
				P_TauxOccupation(2)
			End if 
			//Le cumuls
			P_TauxOccupation(3)
			
		End if 
		
		If (<>vb_T_OccupMinuteurMess)
			CLOSE WINDOW:C154
		End if 
		
		//Mise à jour des variables d'informations
		$vh_Dummy:=Current time:C178
		va_DateMaJ:="Mise à jour le "+String:C10(vd_Date1; Interne date court:K1:7)+" à "+String:C10($vh_Dummy; h mn s:K7:1)
		If (<>vb_T_OccupMinuteur)
			If (<>vl_T_OccupMinuteurTicks>0)
				$vh_Dummy2:=(<>vl_T_OccupMinuteurTicks/60)
				$vh_Dummy:=$vh_Dummy+$vh_Dummy2
				va_DateMaJNext:="Prochaine mise à jour à  "+String:C10($vh_Dummy; h mn s:K7:1)
			End if 
		End if 
		
		
	: ($1=2)
		If (Size of array:C274(<>tl_Occ_CentreRéférence)>0)
			$ii:=1
			Repeat 
				If (<>tl_Occ_CentreUtilisé{$ii}<=0)
					<>tl_Occ_CentreRéférence:=$ii
					P_OccupationTab(3)
				Else 
					$ii:=$ii+1
				End if 
			Until ($ii>Size of array:C274(<>tl_Occ_CentreRéférence))
		End if 
		
	: ($1=3)
		vl_TOC_Capacité:=0
		vl_TOC_Hébergés:=0
		vl_TOC_Hébergés_H:=0
		vl_TOC_Hébergés_F:=0
		vl_TOC_Hébergés_M:=0
		vl_TOC_Reste:=0
		vl_TOC_Taux:=0
		
		If (Size of array:C274(<>tl_Occ_CentreRéférence)>0)
			For ($ii; 1; Size of array:C274(<>tl_Occ_CentreRéférence))
				vl_TOC_Capacité:=vl_TOC_Capacité+<>tl_Occ_CentreCapacité{$ii}
				vl_TOC_Hébergés:=vl_TOC_Hébergés+<>tl_Occ_CentreUtilisé{$ii}
				vl_TOC_Hébergés_H:=vl_TOC_Hébergés_H+<>tl_Occ_CentreUtiliséH{$ii}
				vl_TOC_Hébergés_F:=vl_TOC_Hébergés_F+<>tl_Occ_CentreUtiliséF{$ii}
				vl_TOC_Hébergés_M:=vl_TOC_Hébergés_M+<>tl_Occ_CentreUtiliséM{$ii}
				vl_TOC_Reste:=vl_TOC_Reste+<>tl_Occ_CentreReste{$ii}
			End for 
			If (vl_TOC_Capacité>0)
				vl_TOC_Taux:=Round:C94(((vl_TOC_Hébergés/vl_TOC_Capacité)*100); 2)
			End if 
			
			
		End if 
		
		
	: ($1=10)  //Détail (déployer contracter
		$va_Comparer:=""
		$vb_OK:=False:C215
		
		//••••••••••••••  Conditions
		$vb_115:=(<>ve_T_CentreCode=0)
		If ($vb_115=False:C215)
			ALERT:C41("Cette fonction est de type 115 !")
		Else 
			$vb_OK:=(<>ta_Occ_CentreNom>0)  //Ligne sélectionnée
			$vb_OK:=$vb_OK & (<>te_Occ_CentreNbFils{<>ta_Occ_CentreNom}>0)  //Est ce un centre générique qui à des fils      
		End if 
		
		//••••••••••••••  Etat (Déployé ou pas)
		If ($vb_OK)
			$vb_OK:=False:C215
			Case of 
				: (<>ta_Occ_CentreNom=Size of array:C274(<>ta_Occ_CentreNom))
					$vb_OK:=True:C214
				: (<>ta_Occ_CentreNom<Size of array:C274(<>ta_Occ_CentreNom))
					If (<>tl_Occ_CentreRéfPère{<>ta_Occ_CentreNom+1}=-1)
						If (i_Confirmer("Centre déjà déployé !"+<>va_CR+"Voulez-vous refermer le détail ?"))
							//Contracter le détail du centre
							$vb_OK:=False:C215
							$kk:=<>ta_Occ_CentreNom
							$ii:=$kk+1
							
							Repeat 
								<>tl_Occ_CentreRéférence:=$ii
								P_OccupationTab(3)
								If ($ii>Size of array:C274(<>ta_Occ_CentreNom))
									$vb_OK:=True:C214
								Else 
									$vb_OK:=(<>tl_Occ_CentreRéfPère{$ii}#-1)
								End if 
							Until ($vb_OK)
							
							<>ta_Occ_CentreNom:=$kk
							$vb_OK:=False:C215
						End if 
					Else 
						$vb_OK:=True:C214
					End if 
			End case 
		End if 
		
		//••••••••••••••  Recherche
		If ($vb_OK)
			$vb_OK:=False:C215
			If (<>ta_Occ_CentreRepertoire{<>ta_Occ_CentreNom}>"")
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54=<>ta_Occ_CentreRepertoire{<>ta_Occ_CentreNom})
				MultiSoc_Filter(->[LesCentres:9])
				QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1#<>tl_Occ_CentreRéférence{<>ta_Occ_CentreNom})
				If (Records in selection:C76([LesCentres:9])>0)
					SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_Occ_CentreLiés)
					$vb_OK:=True:C214
				End if 
			End if 
		End if 
		
		//••••••••••••••  Chargement
		If ($vb_OK)
			QUERY WITH ARRAY:C644([LesCentres:9]LC_RéférenceID:1; $tl_Occ_CentreLiés)
			$jj:=Records in selection:C76([LesCentres:9])
			If ($jj>0)
				ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
				FIRST RECORD:C50([LesCentres:9])
				$kk:=<>ta_Occ_CentreNom
				$ii:=$kk+1
				Repeat 
					<>ta_Occ_CentreNom:=<>ta_Occ_CentreNom+1
					P_OccupationTab(4)
					
					<>tl_Occ_CentreRéférence{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_RéférenceID:1
					<>ta_Occ_CentreCode{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_Code:3
					<>ta_Occ_CentreRepertoire{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_Répertoire:54
					<>ta_Occ_CentrePlateforme{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_Plateforme:56
					<>ta_Occ_CentreNom{<>ta_Occ_CentreNom}:=(" "*10)+"- "+[LesCentres:9]LC_Nom:4
					<>tl_Occ_CentreCapacité{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_DispoJour:48
					
					<>tl_Occ_CentreRéfPère{<>ta_Occ_CentreNom}:=-1
					<>ta_Occ_CentreNomPère{<>ta_Occ_CentreNom}:=""
					<>te_Occ_CentreNbFils{<>ta_Occ_CentreNom}:=0
					<>tb_Occ_CentreEtat{<>ta_Occ_CentreNom}:=False:C215
					<>tl_Occ_CentreUtilisé{<>ta_Occ_CentreNom}:=0
					<>tl_Occ_CentreUtiliséH{<>ta_Occ_CentreNom}:=0
					<>tl_Occ_CentreUtiliséF{<>ta_Occ_CentreNom}:=0
					<>tl_Occ_CentreUtiliséM{<>ta_Occ_CentreNom}:=0
					<>tl_Occ_CentreReste{<>ta_Occ_CentreNom}:=0
					<>tr_Occ_CentreTaux{<>ta_Occ_CentreNom}:=0
					
					NEXT RECORD:C51([LesCentres:9])
				Until (End selection:C36([LesCentres:9]))
			End if 
		End if 
		
		//••••••••••••••  Affectation
		If ($vb_OK)
			$jj:=$kk+$jj
			For ($ii; $kk+1; $jj)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=<>tl_Occ_CentreRéférence{$ii}; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
				MultiSoc_Filter(->[HeberGement:5])
				If (Records in selection:C76([HeberGement:5])>0)
					<>tl_Occ_CentreUtilisé{$ii}:=Records in selection:C76([HeberGement:5])
					FIRST RECORD:C50([HeberGement:5])
					Repeat 
						$vl_Position1:=Position:C15("("; [HeberGement:5]HG_EtatCivil:20)
						$vl_Position2:=Position:C15(")"; [HeberGement:5]HG_EtatCivil:20)
						$vb_OK:=($vl_Position1>0)
						$vb_OK:=$vb_OK & ($vl_Position2>0)
						If ($vb_OK)
							If ([HeberGement:5]HG_EtatCivil:20[[($vl_Position2-1)]]="P")
								<>tl_Occ_CentreUtiliséM{$ii}:=<>tl_Occ_CentreUtiliséM{$ii}+1
							Else 
								If ([HeberGement:5]HG_EtatCivil:20[[($vl_Position1+1)]]="F")
									<>tl_Occ_CentreUtiliséF{$ii}:=<>tl_Occ_CentreUtiliséF{$ii}+1
								Else 
									<>tl_Occ_CentreUtiliséH{$ii}:=<>tl_Occ_CentreUtiliséH{$ii}+1
								End if 
							End if 
						End if 
						
						NEXT RECORD:C51([HeberGement:5])
					Until (End selection:C36([HeberGement:5]))
				End if 
				
				//Calcul du taux d'occupation
				If (<>tl_Occ_CentreCapacité{$ii}>0)
					<>tl_Occ_CentreReste{$ii}:=<>tl_Occ_CentreCapacité{$ii}-<>tl_Occ_CentreUtilisé{$ii}
					//     ◊tr_Occ_CentreTaux{$ii}:=Arrondi(((◊tl_Occ_CentreUtilisé{$ii}/◊tl_Occ_Centr
				End if 
			End for 
			<>ta_Occ_CentreNom:=$kk
		End if 
		
		//••••••••••••••  Regroupement
		If ($vb_OK)
			$vb_OK:=False:C215
			$va_Comparer:=""
			$ii:=<>ta_Occ_CentreNom+1
			Repeat 
				If (Substring:C12(<>ta_Occ_CentreNom{$ii}; 13; 4)=$va_Comparer)
					<>tl_Occ_CentreCapacité{$ii-1}:=<>tl_Occ_CentreCapacité{$ii-1}+<>tl_Occ_CentreCapacité{$ii}
					<>tl_Occ_CentreUtilisé{$ii-1}:=<>tl_Occ_CentreUtilisé{$ii-1}+<>tl_Occ_CentreUtilisé{$ii}
					<>tl_Occ_CentreUtiliséM{$ii-1}:=<>tl_Occ_CentreUtiliséM{$ii-1}+<>tl_Occ_CentreUtiliséM{$ii}
					<>tl_Occ_CentreUtiliséF{$ii-1}:=<>tl_Occ_CentreUtiliséF{$ii-1}+<>tl_Occ_CentreUtiliséF{$ii}
					<>tl_Occ_CentreUtiliséH{$ii-1}:=<>tl_Occ_CentreUtiliséH{$ii-1}+<>tl_Occ_CentreUtiliséH{$ii}
					<>tl_Occ_CentreReste{$ii-1}:=<>tl_Occ_CentreReste{$ii}-<>tl_Occ_CentreReste{$ii}
					
					<>tl_Occ_CentreRéférence:=$ii
					$va_Comparer:=Substring:C12(<>ta_Occ_CentreNom{$ii}; 13; 4)
					P_OccupationTab(3)
				Else 
					$va_Comparer:=Substring:C12(<>ta_Occ_CentreNom{$ii}; 13; 4)
					$ii:=$ii+1
				End if 
				If ($ii>Size of array:C274(<>ta_Occ_CentreNom))
					$vb_OK:=True:C214
				Else 
					$vb_OK:=(<>tl_Occ_CentreRéfPère{$ii}#-1)
				End if 
			Until ($vb_OK)
		End if 
		
		
		
	: ($1=11)  //Détail Plus(déployer contracter
		$va_Comparer:=""
		$vb_OK:=False:C215
		
		//••••••••••••••  Conditions
		$vb_115:=(<>ve_T_CentreCode=0)
		If ($vb_115=False:C215)
			ALERT:C41("Cette fonction est de type 115 !")
		Else 
			$vb_OK:=(<>ta_Occ_CentreNom>0)  //Ligne sélectionnée
			If (<>ta_Occ_CentreNom>0) & (<>ta_Occ_CentreNom<=Size of array:C274(<>te_Occ_CentreNbFils))
				$vb_OK:=$vb_OK & (<>te_Occ_CentreNbFils{<>ta_Occ_CentreNom}>0)  //Est ce un centre générique qui à des fils      
			Else 
				$vb_OK:=False:C215
			End if 
		End if 
		
		//••••••••••••••  Etat (Déployé ou pas)
		If ($vb_OK)
			$vb_OK:=False:C215
			Case of 
				: (<>ta_Occ_CentreNom=Size of array:C274(<>ta_Occ_CentreNom))
					$vb_OK:=True:C214
				: (<>ta_Occ_CentreNom<Size of array:C274(<>ta_Occ_CentreNom))
					If (<>tl_Occ_CentreRéfPère{<>ta_Occ_CentreNom+1}=-1)
						If (i_Confirmer("Centre déjà déployé !"+<>va_CR+"Voulez-vous refermer le détail ?"))
							//Contracter le détail du centre
							$vb_OK:=False:C215
							$kk:=<>ta_Occ_CentreNom
							$ii:=$kk+1
							
							Repeat 
								<>tl_Occ_CentreRéférence:=$ii
								P_OccupationTab(3)
								If ($ii>Size of array:C274(<>ta_Occ_CentreNom))
									$vb_OK:=True:C214
								Else 
									$vb_OK:=(<>tl_Occ_CentreRéfPère{$ii}#-1)
								End if 
							Until ($vb_OK)
							
							<>ta_Occ_CentreNom:=$kk
							$vb_OK:=False:C215
						End if 
					Else 
						$vb_OK:=True:C214
					End if 
			End case 
		End if 
		
		//••••••••••••••  Recherche
		If ($vb_OK)
			$vb_OK:=False:C215
			If (<>ta_Occ_CentreRepertoire{<>ta_Occ_CentreNom}>"")
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54=<>ta_Occ_CentreRepertoire{<>ta_Occ_CentreNom})
				MultiSoc_Filter(->[LesCentres:9])
				QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1#<>tl_Occ_CentreRéférence{<>ta_Occ_CentreNom})
				If (Records in selection:C76([LesCentres:9])>0)
					SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_Occ_CentreLiés)
					$vb_OK:=True:C214
				End if 
			End if 
		End if 
		
		//••••••••••••••  Chargement
		If ($vb_OK)
			QUERY WITH ARRAY:C644([LesCentres:9]LC_RéférenceID:1; $tl_Occ_CentreLiés)
			$jj:=Records in selection:C76([LesCentres:9])
			If ($jj>0)
				ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
				FIRST RECORD:C50([LesCentres:9])
				$kk:=<>ta_Occ_CentreNom
				$ii:=$kk+1
				Repeat 
					<>ta_Occ_CentreNom:=<>ta_Occ_CentreNom+1
					P_OccupationTab(4)
					
					<>tl_Occ_CentreRéférence{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_RéférenceID:1
					<>ta_Occ_CentreCode{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_Code:3
					<>ta_Occ_CentreRepertoire{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_Répertoire:54
					<>ta_Occ_CentrePlateforme{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_Plateforme:56
					<>ta_Occ_CentreNom{<>ta_Occ_CentreNom}:=(" "*10)+"- "+[LesCentres:9]LC_Nom:4
					<>tl_Occ_CentreCapacité{<>ta_Occ_CentreNom}:=[LesCentres:9]LC_DispoJour:48
					
					<>tl_Occ_CentreRéfPère{<>ta_Occ_CentreNom}:=-1
					<>ta_Occ_CentreNomPère{<>ta_Occ_CentreNom}:=""
					<>te_Occ_CentreNbFils{<>ta_Occ_CentreNom}:=0
					<>tb_Occ_CentreEtat{<>ta_Occ_CentreNom}:=False:C215
					<>tl_Occ_CentreUtilisé{<>ta_Occ_CentreNom}:=0
					<>tl_Occ_CentreUtiliséH{<>ta_Occ_CentreNom}:=0
					<>tl_Occ_CentreUtiliséF{<>ta_Occ_CentreNom}:=0
					<>tl_Occ_CentreUtiliséM{<>ta_Occ_CentreNom}:=0
					<>tl_Occ_CentreReste{<>ta_Occ_CentreNom}:=0
					<>tr_Occ_CentreTaux{<>ta_Occ_CentreNom}:=0
					
					NEXT RECORD:C51([LesCentres:9])
				Until (End selection:C36([LesCentres:9]))
			End if 
		End if 
		
		//••••••••••••••  Affectation
		If ($vb_OK)
			$jj:=$kk+$jj
			For ($ii; $kk+1; $jj)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=<>tl_Occ_CentreRéférence{$ii}; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
				MultiSoc_Filter(->[HeberGement:5])
				If (Records in selection:C76([HeberGement:5])>0)
					<>tl_Occ_CentreUtilisé{$ii}:=Records in selection:C76([HeberGement:5])
					FIRST RECORD:C50([HeberGement:5])
					Repeat 
						$vl_Position1:=Position:C15("("; [HeberGement:5]HG_EtatCivil:20)
						$vl_Position2:=Position:C15(")"; [HeberGement:5]HG_EtatCivil:20)
						$vb_OK:=($vl_Position1>0)
						$vb_OK:=$vb_OK & ($vl_Position2>0)
						If ($vb_OK)
							If ([HeberGement:5]HG_EtatCivil:20[[($vl_Position2-1)]]="P")
								<>tl_Occ_CentreUtiliséM{$ii}:=<>tl_Occ_CentreUtiliséM{$ii}+1
							Else 
								If ([HeberGement:5]HG_EtatCivil:20[[($vl_Position1+1)]]="F")
									<>tl_Occ_CentreUtiliséF{$ii}:=<>tl_Occ_CentreUtiliséF{$ii}+1
								Else 
									<>tl_Occ_CentreUtiliséH{$ii}:=<>tl_Occ_CentreUtiliséH{$ii}+1
								End if 
							End if 
						End if 
						NEXT RECORD:C51([HeberGement:5])
					Until (End selection:C36([HeberGement:5]))
				End if 
				
				//Calcul du taux d'occupation
				If (<>tl_Occ_CentreCapacité{$ii}>0)
					<>tl_Occ_CentreReste{$ii}:=<>tl_Occ_CentreCapacité{$ii}-<>tl_Occ_CentreUtilisé{$ii}
					//     ◊tr_Occ_CentreTaux{$ii}:=Arrondi(((◊tl_Occ_CentreUtilisé{$ii}/◊tl_Occ_Centr
				End if 
			End for 
			<>ta_Occ_CentreNom:=$kk
		End if 
		
End case 