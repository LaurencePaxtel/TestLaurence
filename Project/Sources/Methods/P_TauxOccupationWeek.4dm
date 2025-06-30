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
C_TIME:C306($vh_Dummy)
C_BOOLEAN:C305($vb_OK; $vb_115)
C_DATE:C307($vd_Date)

C_TEXT:C284($va_Comparer)

Case of 
	: ($1=0)
		
	: ($1=1)
		If (ve_CasOccupation=0)
			i_Message("Mise à jour en cours…")
		End if 
		P_OccupationTabWeek(0)
		//ESt-ce un 115 ou un CHRS
		//115 : numérotation des centres entre 0 et 999 999
		//Les autres sont à partir de 1 000 000
		$vb_115:=(<>ve_T_CentreCode=0)
		
		$vb_OK:=False:C215
		
		//• SÉLECTION DES CENTRES
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
			SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_Occ_CentreRéférence; [LesCentres:9]LC_Code:3; ta_Occ_CentreCode; [LesCentres:9]LC_Répertoire:54; ta_Occ_CentreRepertoire; [LesCentres:9]LC_Plateforme:56; ta_Occ_CentrePlateforme; [LesCentres:9]LC_Nom:4; ta_Occ_CentreNom; [LesCentres:9]LC_DispoJour:48; tl_Occ_CentreCapacité)
			P_OccupationTabWeek(1)
			For ($ii; 1; Size of array:C274(tl_Occ_CentreRéférence))
				tl_Occ_CentreRéfPère{$ii}:=0
				ta_Occ_CentreNomPère{$ii}:=""
				te_Occ_CentreNbFils{$ii}:=0
				tb_Occ_CentreEtat{$ii}:=False:C215
				
				tl_Occ_CentreUtilisé_L{$ii}:=0
				tl_Occ_CentreUtilisé_M{$ii}:=0
				tl_Occ_CentreUtilisé_Me{$ii}:=0
				tl_Occ_CentreUtilisé_J{$ii}:=0
				tl_Occ_CentreUtilisé_V{$ii}:=0
				tl_Occ_CentreUtilisé_S{$ii}:=0
				tl_Occ_CentreUtilisé_D{$ii}:=0
			End for 
		End if 
		
		
		//•• SÉLECTION DES CENTRES LIÉES et DES HÉBERGEMENTS
		If ($vb_OK)
			For ($ii; 1; Size of array:C274(tl_Occ_CentreRéférence))
				
				If (ve_CasOccupation=0)
					i_MessageSeul("Mise à jour en cours : "+String:C10(Size of array:C274(tl_Occ_CentreRéférence))+"/"+String:C10($ii))
				End if 
				
				//••• LES CENTRE LIÉS
				ARRAY LONGINT:C221(tl_Occ_CentreLiés; 0)
				te_Occ_CentreNbFils{$ii}:=0
				If ($vb_115)
					If (ta_Occ_CentreRepertoire{$ii}="115")
						$jj:=Size of array:C274(tl_Occ_CentreLiés)+1
						INSERT IN ARRAY:C227(tl_Occ_CentreLiés; $jj)
						tl_Occ_CentreLiés{$jj}:=tl_Occ_CentreRéférence{$ii}
					Else 
						If (ta_Occ_CentreRepertoire{$ii}>"")
							QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54=ta_Occ_CentreRepertoire{$ii})
							QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1#tl_Occ_CentreRéférence{$ii})
							If (Records in selection:C76([LesCentres:9])>0)
								SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_Occ_CentreLiés)
								te_Occ_CentreNbFils{$ii}:=Size of array:C274(tl_Occ_CentreLiés)
							End if 
						End if 
					End if 
				Else   //Ce n'est pas le 115
					$jj:=Size of array:C274(tl_Occ_CentreLiés)+1
					INSERT IN ARRAY:C227(tl_Occ_CentreLiés; $jj)
					tl_Occ_CentreLiés{$jj}:=tl_Occ_CentreRéférence{$ii}
				End if 
				
				//•• RAZ
				//  tl_Occ_CentreUtilisé_L{$ii}:=0
				//  tl_Occ_CentreUtilisé_M{$ii}:=0
				// tl_Occ_CentreUtilisé_Me{$ii}:=0
				//tl_Occ_CentreUtilisé_J{$ii}:=0
				//tl_Occ_CentreUtilisé_V{$ii}:=0
				//  tl_Occ_CentreUtilisé_S{$ii}:=0
				//   tl_Occ_CentreUtilisé_D{$ii}:=0
				
				//••• CALCUL DU NOMBRE DE LITS OCCUPÉS
				If (Size of array:C274(tl_Occ_CentreLiés)>0)
					For ($jj; 1; Size of array:C274(tl_Occ_CentreLiés))
						
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=tl_Occ_CentreLiés{$jj}; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
						
						MultiSoc_Filter(->[HeberGement:5])
						
						If (Records in selection:C76([HeberGement:5])>0)
							CREATE SET:C116([HeberGement:5]; "$E_Hébergements")
							$vd_Date:=vd_Date1
							USE SET:C118("$E_Hébergements")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
							tl_Occ_CentreUtilisé_L{$ii}:=tl_Occ_CentreUtilisé_L{$ii}+Records in selection:C76([HeberGement:5])
							$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 1)
							USE SET:C118("$E_Hébergements")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
							tl_Occ_CentreUtilisé_M{$ii}:=tl_Occ_CentreUtilisé_M{$ii}+Records in selection:C76([HeberGement:5])
							$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 2)
							USE SET:C118("$E_Hébergements")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
							tl_Occ_CentreUtilisé_ME{$ii}:=tl_Occ_CentreUtilisé_ME{$ii}+Records in selection:C76([HeberGement:5])
							$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 3)
							USE SET:C118("$E_Hébergements")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
							tl_Occ_CentreUtilisé_J{$ii}:=tl_Occ_CentreUtilisé_J{$ii}+Records in selection:C76([HeberGement:5])
							$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 4)
							USE SET:C118("$E_Hébergements")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
							tl_Occ_CentreUtilisé_V{$ii}:=tl_Occ_CentreUtilisé_V{$ii}+Records in selection:C76([HeberGement:5])
							$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 5)
							USE SET:C118("$E_Hébergements")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
							tl_Occ_CentreUtilisé_S{$ii}:=tl_Occ_CentreUtilisé_S{$ii}+Records in selection:C76([HeberGement:5])
							$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 6)
							USE SET:C118("$E_Hébergements")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
							tl_Occ_CentreUtilisé_D{$ii}:=tl_Occ_CentreUtilisé_D{$ii}+Records in selection:C76([HeberGement:5])
							
							CLEAR SET:C117("$E_Hébergements")
						End if 
						
					End for 
				End if 
			End for 
			
			If (7=7)
				//Option d'affichage : que les centres où il y a des lits occupés
				If (vl_Rafraichir=1)
					P_TauxOccupationWeek(2)
				End if 
				//Le cumuls
				P_TauxOccupationWeek(3)
			End if 
		End if 
		
		//Mise à jour des variables d'informations
		$vh_Dummy:=Current time:C178
		va_DateMaJ:="Mise à jour le "+String:C10(vd_Date1; Interne date court:K1:7)+" à "+String:C10($vh_Dummy; h mn s:K7:1)
		va_DateMaJNext:=""
		
		If (ve_CasOccupation=0)
			CLOSE WINDOW:C154
		End if 
		
	: ($1=2)
		If (Size of array:C274(tl_Occ_CentreRéférence)>0)
			$ii:=1
			Repeat 
				If ((tl_Occ_CentreUtilisé_L{$ii}+tl_Occ_CentreUtilisé_M{$ii}+tl_Occ_CentreUtilisé_Me{$ii}+tl_Occ_CentreUtilisé_J{$ii}+tl_Occ_CentreUtilisé_V{$ii}+tl_Occ_CentreUtilisé_S{$ii}+tl_Occ_CentreUtilisé_D{$ii})=0)
					tl_Occ_CentreRéférence:=$ii
					P_OccupationTabWeek(3)
					
				Else 
					$ii:=$ii+1
				End if 
			Until ($ii>Size of array:C274(tl_Occ_CentreRéférence))
		End if 
		
	: ($1=3)
		vl_TOC_Capacité:=0
		vl_TOC_Hébergés_L:=0
		vl_TOC_Hébergés_M:=0
		vl_TOC_Hébergés_Me:=0
		vl_TOC_Hébergés_J:=0
		vl_TOC_Hébergés_V:=0
		vl_TOC_Hébergés_S:=0
		vl_TOC_Hébergés_D:=0
		
		If (Size of array:C274(tl_Occ_CentreRéférence)>0)
			For ($ii; 1; Size of array:C274(tl_Occ_CentreRéférence))
				vl_TOC_Capacité:=vl_TOC_Capacité+tl_Occ_CentreCapacité{$ii}
				vl_TOC_Hébergés_L:=vl_TOC_Hébergés_L+tl_Occ_CentreUtilisé_L{$ii}
				vl_TOC_Hébergés_M:=vl_TOC_Hébergés_M+tl_Occ_CentreUtilisé_M{$ii}
				vl_TOC_Hébergés_Me:=vl_TOC_Hébergés_Me+tl_Occ_CentreUtilisé_Me{$ii}
				vl_TOC_Hébergés_J:=vl_TOC_Hébergés_J+tl_Occ_CentreUtilisé_J{$ii}
				vl_TOC_Hébergés_V:=vl_TOC_Hébergés_V+tl_Occ_CentreUtilisé_V{$ii}
				vl_TOC_Hébergés_S:=vl_TOC_Hébergés_S+tl_Occ_CentreUtilisé_S{$ii}
				vl_TOC_Hébergés_D:=vl_TOC_Hébergés_D+tl_Occ_CentreUtilisé_D{$ii}
			End for 
			
		End if 
		
		
	: ($1=10)  //Détail (déployer contracter
		$va_Comparer:=""
		$vb_OK:=False:C215
		
		//••••••••••••••  Conditions
		$vb_115:=(<>ve_T_CentreCode=0)
		If ($vb_115=False:C215)
			ALERT:C41("Cette fonction est de type 115 !")
		Else 
			$vb_OK:=(ta_Occ_CentreNom>0)  //Ligne sélectionnée
			$vb_OK:=$vb_OK & (te_Occ_CentreNbFils{ta_Occ_CentreNom}>0)  //Est ce un centre générique qui à des fils      
		End if 
		
		//••••••••••••••  Etat (Déployé ou pas)
		If ($vb_OK)
			$vb_OK:=False:C215
			Case of 
				: (ta_Occ_CentreNom=Size of array:C274(ta_Occ_CentreNom))
					$vb_OK:=True:C214
				: (ta_Occ_CentreNom<Size of array:C274(ta_Occ_CentreNom))
					If (tl_Occ_CentreRéfPère{ta_Occ_CentreNom+1}=-1)
						If (i_Confirmer("Centre déjà déployé !"+<>va_CR+"Voulez-vous refermer le détail ?"))
							//Contracter le détail du centre
							$vb_OK:=False:C215
							$kk:=ta_Occ_CentreNom
							$ii:=$kk+1
							
							Repeat 
								tl_Occ_CentreRéférence:=$ii
								P_OccupationTabWeek(3)
								If ($ii>Size of array:C274(ta_Occ_CentreNom))
									$vb_OK:=True:C214
								Else 
									$vb_OK:=(tl_Occ_CentreRéfPère{$ii}#-1)
								End if 
							Until ($vb_OK)
							
							ta_Occ_CentreNom:=$kk
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
			If (ta_Occ_CentreRepertoire{ta_Occ_CentreNom}>"")
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54=ta_Occ_CentreRepertoire{ta_Occ_CentreNom})
				MultiSoc_Filter(->[LesCentres:9])
				QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1#tl_Occ_CentreRéférence{ta_Occ_CentreNom})
				If (Records in selection:C76([LesCentres:9])>0)
					SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_Occ_CentreLiés)
					$vb_OK:=True:C214
				End if 
			End if 
		End if 
		
		//••••••••••••••  Chargement
		If ($vb_OK)
			If (ve_CasOccupation=0)
				i_Message("1/3 - Centres : chargement")
			End if 
			QUERY WITH ARRAY:C644([LesCentres:9]LC_RéférenceID:1; $tl_Occ_CentreLiés)
			$jj:=Records in selection:C76([LesCentres:9])
			If ($jj>0)
				ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
				FIRST RECORD:C50([LesCentres:9])
				$kk:=ta_Occ_CentreNom
				$ii:=$kk+1
				Repeat 
					ta_Occ_CentreNom:=ta_Occ_CentreNom+1
					P_OccupationTabWeek(4)
					
					tl_Occ_CentreRéférence{ta_Occ_CentreNom}:=[LesCentres:9]LC_RéférenceID:1
					ta_Occ_CentreCode{ta_Occ_CentreNom}:=[LesCentres:9]LC_Code:3
					ta_Occ_CentreRepertoire{ta_Occ_CentreNom}:=[LesCentres:9]LC_Répertoire:54
					ta_Occ_CentrePlateforme{ta_Occ_CentreNom}:=[LesCentres:9]LC_Plateforme:56
					ta_Occ_CentreNom{ta_Occ_CentreNom}:=(" "*10)+"- "+[LesCentres:9]LC_Nom:4
					tl_Occ_CentreCapacité{ta_Occ_CentreNom}:=[LesCentres:9]LC_DispoJour:48
					
					tl_Occ_CentreRéfPère{ta_Occ_CentreNom}:=-1
					ta_Occ_CentreNomPère{ta_Occ_CentreNom}:=""
					te_Occ_CentreNbFils{ta_Occ_CentreNom}:=0
					tb_Occ_CentreEtat{ta_Occ_CentreNom}:=False:C215
					tl_Occ_CentreUtilisé_L{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_M{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_Me{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_J{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_V{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_S{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_D{ta_Occ_CentreNom}:=0
					
					NEXT RECORD:C51([LesCentres:9])
				Until (End selection:C36([LesCentres:9]))
			End if 
			If (ve_CasOccupation=0)
				CLOSE WINDOW:C154
			End if 
		End if 
		
		//••••••••••••••  Affectation
		If ($vb_OK)
			If (ve_CasOccupation=0)
				i_Message("2/3 - Affectation des centres : chargement")
			End if 
			$jj:=$kk+$jj
			For ($ii; $kk+1; $jj)
				If (ve_CasOccupation=0)
					i_MessageSeul("2/3 - Affectation des centres : "+String:C10($jj)+"/"+String:C10($ii))
				End if 
				
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=tl_Occ_CentreRéférence{$ii}; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
				
				MultiSoc_Filter(->[HeberGement:5])
				
				If (Records in selection:C76([HeberGement:5])>0)
					CREATE SET:C116([HeberGement:5]; "$E_Hébergements")
					$vd_Date:=vd_Date1
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_L{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 1)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_M{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 2)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_ME{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 3)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_J{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 4)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_V{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 5)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_S{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 6)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_D{$ii}:=Records in selection:C76([HeberGement:5])
					
					CLEAR SET:C117("$E_Hébergements")
				End if 
				
			End for 
			ta_Occ_CentreNom:=$kk
			If (ve_CasOccupation=0)
				CLOSE WINDOW:C154
			End if 
		End if 
		
		//••••••••••••••  Regroupement
		If ($vb_OK)
			If (ve_CasOccupation=0)
				i_Message("3/3 - Regroupement des centres : Regroupement")
			End if 
			$vb_OK:=False:C215
			$va_Comparer:=""
			$ii:=ta_Occ_CentreNom+1
			Repeat 
				If (Substring:C12(ta_Occ_CentreNom{$ii}; 13; 4)=$va_Comparer)
					tl_Occ_CentreCapacité{$ii-1}:=tl_Occ_CentreCapacité{$ii-1}+tl_Occ_CentreCapacité{$ii}
					
					tl_Occ_CentreUtilisé_L{$ii-1}:=tl_Occ_CentreUtilisé_L{$ii-1}+tl_Occ_CentreUtilisé_L{$ii}
					tl_Occ_CentreUtilisé_M{$ii-1}:=tl_Occ_CentreUtilisé_M{$ii-1}+tl_Occ_CentreUtilisé_M{$ii}
					tl_Occ_CentreUtilisé_Me{$ii-1}:=tl_Occ_CentreUtilisé_Me{$ii-1}+tl_Occ_CentreUtilisé_Me{$ii}
					tl_Occ_CentreUtilisé_J{$ii-1}:=tl_Occ_CentreUtilisé_J{$ii-1}+tl_Occ_CentreUtilisé_J{$ii}
					tl_Occ_CentreUtilisé_V{$ii-1}:=tl_Occ_CentreUtilisé_V{$ii-1}+tl_Occ_CentreUtilisé_V{$ii}
					tl_Occ_CentreUtilisé_S{$ii-1}:=tl_Occ_CentreUtilisé_S{$ii-1}+tl_Occ_CentreUtilisé_S{$ii}
					tl_Occ_CentreUtilisé_D{$ii-1}:=tl_Occ_CentreUtilisé_D{$ii-1}+tl_Occ_CentreUtilisé_D{$ii}
					
					tl_Occ_CentreRéférence:=$ii
					$va_Comparer:=Substring:C12(ta_Occ_CentreNom{$ii}; 13; 4)
					P_OccupationTabWeek(3)
				Else 
					$va_Comparer:=Substring:C12(ta_Occ_CentreNom{$ii}; 13; 4)
					$ii:=$ii+1
				End if 
				If ($ii>Size of array:C274(ta_Occ_CentreNom))
					$vb_OK:=True:C214
				Else 
					$vb_OK:=(tl_Occ_CentreRéfPère{$ii}#-1)
				End if 
			Until ($vb_OK)
			If (ve_CasOccupation=0)
				CLOSE WINDOW:C154
			End if 
		End if 
		
		
		
	: ($1=11)  //Détail Plus(déployer contracter
		$va_Comparer:=""
		$vb_OK:=False:C215
		
		//••••••••••••••  Conditions
		$vb_115:=(<>ve_T_CentreCode=0)
		If ($vb_115=False:C215)
			ALERT:C41("Cette fonction est de type 115 !")
		Else 
			$vb_OK:=(ta_Occ_CentreNom>0)  //Ligne sélectionnée
			$vb_OK:=$vb_OK & (te_Occ_CentreNbFils{ta_Occ_CentreNom}>0)  //Est ce un centre générique qui à des fils      
		End if 
		
		//••••••••••••••  Etat (Déployé ou pas)
		If ($vb_OK)
			$vb_OK:=False:C215
			Case of 
				: (ta_Occ_CentreNom=Size of array:C274(ta_Occ_CentreNom))
					$vb_OK:=True:C214
				: (ta_Occ_CentreNom<Size of array:C274(ta_Occ_CentreNom))
					If (tl_Occ_CentreRéfPère{ta_Occ_CentreNom+1}=-1)
						If (i_Confirmer("Centre déjà déployé !"+<>va_CR+"Voulez-vous refermer le détail ?"))
							//Contracter le détail du centre
							$vb_OK:=False:C215
							$kk:=ta_Occ_CentreNom
							$ii:=$kk+1
							
							Repeat 
								tl_Occ_CentreRéférence:=$ii
								P_OccupationTabWeek(3)
								If ($ii>Size of array:C274(ta_Occ_CentreNom))
									$vb_OK:=True:C214
								Else 
									$vb_OK:=(tl_Occ_CentreRéfPère{$ii}#-1)
								End if 
							Until ($vb_OK)
							
							ta_Occ_CentreNom:=$kk
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
			If (ta_Occ_CentreRepertoire{ta_Occ_CentreNom}>"")
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54=ta_Occ_CentreRepertoire{ta_Occ_CentreNom})
				MultiSoc_Filter(->[LesCentres:9])
				QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1#tl_Occ_CentreRéférence{ta_Occ_CentreNom})
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
				$kk:=ta_Occ_CentreNom
				$ii:=$kk+1
				Repeat 
					ta_Occ_CentreNom:=ta_Occ_CentreNom+1
					P_OccupationTabWeek(4)
					
					tl_Occ_CentreRéférence{ta_Occ_CentreNom}:=[LesCentres:9]LC_RéférenceID:1
					ta_Occ_CentreCode{ta_Occ_CentreNom}:=[LesCentres:9]LC_Code:3
					ta_Occ_CentreRepertoire{ta_Occ_CentreNom}:=[LesCentres:9]LC_Répertoire:54
					ta_Occ_CentrePlateforme{ta_Occ_CentreNom}:=[LesCentres:9]LC_Plateforme:56
					ta_Occ_CentreNom{ta_Occ_CentreNom}:=(" "*10)+"- "+[LesCentres:9]LC_Nom:4
					tl_Occ_CentreCapacité{ta_Occ_CentreNom}:=[LesCentres:9]LC_DispoJour:48
					
					tl_Occ_CentreRéfPère{ta_Occ_CentreNom}:=-1
					ta_Occ_CentreNomPère{ta_Occ_CentreNom}:=""
					te_Occ_CentreNbFils{ta_Occ_CentreNom}:=0
					tb_Occ_CentreEtat{ta_Occ_CentreNom}:=False:C215
					tl_Occ_CentreUtilisé_L{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_M{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_Me{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_J{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_V{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_S{ta_Occ_CentreNom}:=0
					tl_Occ_CentreUtilisé_D{ta_Occ_CentreNom}:=0
					
					NEXT RECORD:C51([LesCentres:9])
				Until (End selection:C36([LesCentres:9]))
			End if 
		End if 
		
		//••••••••••••••  Affectation
		If ($vb_OK)
			$jj:=$kk+$jj
			For ($ii; $kk+1; $jj)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4<=vd_Date1; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=tl_Occ_CentreRéférence{$ii}; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
				MultiSoc_Filter(->[HeberGement:5])
				If (Records in selection:C76([HeberGement:5])>0)
					CREATE SET:C116([HeberGement:5]; "$E_Hébergements")
					$vd_Date:=vd_Date1
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_L{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 1)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_M{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 2)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_ME{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 3)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_J{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 4)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_V{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 5)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_S{$ii}:=Records in selection:C76([HeberGement:5])
					$vd_Date:=Add to date:C393(vd_Date1; 0; 0; 6)
					USE SET:C118("$E_Hébergements")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date)
					tl_Occ_CentreUtilisé_D{$ii}:=Records in selection:C76([HeberGement:5])
					
					CLEAR SET:C117("$E_Hébergements")
				End if 
				
				
				
			End for 
			ta_Occ_CentreNom:=$kk
		End if 
		
End case 