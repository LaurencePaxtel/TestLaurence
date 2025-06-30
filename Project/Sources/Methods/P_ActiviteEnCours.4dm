//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_ActiviteEnCours
//{          Lundi 6 février 2012 à 11:30:00
//{          Développement : GABBAY Jean-Guy
//{==================================================} 
C_BOOLEAN:C305($0)
$0:=False:C215
C_LONGINT:C283($1)
C_LONGINT:C283($vl_Lignes; $vl_LigneEtatCivil; $vl_TrancheLigne; $vl_Jours; $vl_JoursFamille; $vl_RéfHB; $vl_Jours)
C_LONGINT:C283($vl_BlancsEtCv; $vl_BlancsTotal; $vl_BlancsSsT)
$vl_BlancsSsT:=5
$vl_BlancsEtCv:=15
$vl_BlancsTotal:=50

//◊va_T_RefusCHRS:=""
//◊va_T_RefusDEMANDEUR:=""
//◊va_T_RefusAFFECTE:=""


C_TEXT:C284($va_EtCivil)
C_TEXT:C284($va_EtCv)
C_TEXT:C284($va_FamCle)
C_BOOLEAN:C305($va_FamChef)
C_LONGINT:C283($vl_LC_ID)

C_BOOLEAN:C305($vb_OKNewPersonne; $vb_OKNewPersonne2; $vb_OKNewFamille)

C_TIME:C306($h_RefDoc)
C_TEXT:C284($vt_Texte)


Case of 
	: ($1=0)
		
		
		//Les centres : 01/2/2011
		ARRAY TEXT:C222(ta_VeilCentre; 0)
		ARRAY LONGINT:C221(tl_VeilCentre; 0)
		ARRAY INTEGER:C220(te_VeilCentre; 0)
		C_TEXT:C284(va_VeilCentrePrefixe)
		
		ALL RECORDS:C47([LesCentres:9])
		MultiSoc_Filter(->[LesCentres:9])
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Niveau:52; >; *)
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_Nom:4; ta_VeilCentre; [LesCentres:9]LC_RéférenceID:1; tl_VeilCentre)
		ARRAY INTEGER:C220(te_VeilCentre; Size of array:C274(ta_VeilCentre))
		For ($ii; 1; Size of array:C274(ta_VeilCentre))
			te_VeilCentre{$ii}:=1
		End for 
		va_VeilCentrePrefixe:=""
		
		C_LONGINT:C283(vl_TrancheColEtatCivil; vl_LigneEtatCivil)
		vl_LigneEtatCivil:=7
		ARRAY TEXT:C222(ta_LigneEtatCivil; vl_LigneEtatCivil)
		ARRAY TEXT:C222(ta_LigneCodeEtatCivil; vl_LigneEtatCivil)
		ta_LigneEtatCivil{1}:="Homme seul"  //(HS)
		ta_LigneEtatCivil{2}:="Femme seule"  //(FS)"
		ta_LigneEtatCivil{3}:="Couples"  //(HC-FC)
		ta_LigneEtatCivil{4}:="Homme avec enfants"  //(HE)
		ta_LigneEtatCivil{5}:="Femme avec enfants"  //(FE)
		ta_LigneEtatCivil{6}:="Familles"  //(HF-FF)
		ta_LigneEtatCivil{7}:="Enfants"  //(FP-HP)
		
		
		$ii:=56
		ARRAY TEXT:C222(tt_ActiviteTitre; $ii)
		ARRAY LONGINT:C221(tl_ActiviteFiches; $ii)
		ARRAY LONGINT:C221(tl_ActiviteEtatcivil; $ii)
		ARRAY LONGINT:C221(tl_ActivitePersonnes; $ii)
		ARRAY TEXT:C222(ta_ActiviteType; $ii)
		
		
		$vl_Lignes:=1
		tt_ActiviteTitre{$vl_Lignes}:="•• Nombre total de demandes"
		tt_ActiviteTitre{$vl_Lignes}:="NOMBRE TOTAL DE DEMANDES"
		ta_ActiviteType{$vl_Lignes}:="T"
		$vl_Lignes:=1+1
		$vl_LigneEtatCivil:=0
		For ($ii; $vl_Lignes; vl_LigneEtatCivil+$vl_Lignes-1)
			$vl_LigneEtatCivil:=$vl_LigneEtatCivil+1
			tt_ActiviteTitre{$ii}:=("  "*$vl_BlancsEtCv)+ta_LigneEtatCivil{$vl_LigneEtatCivil}
			ta_ActiviteType{$ii}:="S"
		End for 
		$vl_Lignes:=$vl_Lignes+vl_LigneEtatCivil
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsTotal)+"TOTAL"
		ta_ActiviteType{$vl_Lignes}:="ST"
		
		$vl_Lignes:=$vl_Lignes+1
		tt_ActiviteTitre{$vl_Lignes}:="••Nombre total de demandes traitées"
		tt_ActiviteTitre{$vl_Lignes}:="NOMBRE TOTAL DE DEMANDES TRAITEES"
		ta_ActiviteType{$vl_Lignes}:="T"
		
		$vl_Lignes:=$vl_Lignes+1
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsSsT)+"Nombre d'orientations"
		ta_ActiviteType{$vl_Lignes}:="Ts"
		$vl_Lignes:=$vl_Lignes+1
		$vl_LigneEtatCivil:=0
		For ($ii; $vl_Lignes; vl_LigneEtatCivil+$vl_Lignes-1)
			$vl_LigneEtatCivil:=$vl_LigneEtatCivil+1
			tt_ActiviteTitre{$ii}:=("  "*$vl_BlancsEtCv)+ta_LigneEtatCivil{$vl_LigneEtatCivil}
			ta_ActiviteType{$ii}:="S"
		End for 
		$vl_Lignes:=$vl_Lignes+vl_LigneEtatCivil
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsTotal)+"TOTAL"
		ta_ActiviteType{$vl_Lignes}:="ST"
		
		$vl_Lignes:=$vl_Lignes+1
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsSsT)+"Nombre d'affectations"
		ta_ActiviteType{$vl_Lignes}:="Ts"
		$vl_Lignes:=$vl_Lignes+1
		$vl_LigneEtatCivil:=0
		For ($ii; $vl_Lignes; vl_LigneEtatCivil+$vl_Lignes-1)
			$vl_LigneEtatCivil:=$vl_LigneEtatCivil+1
			tt_ActiviteTitre{$ii}:=("  "*$vl_BlancsEtCv)+ta_LigneEtatCivil{$vl_LigneEtatCivil}
			ta_ActiviteType{$ii}:="S"
		End for 
		$vl_Lignes:=$vl_Lignes+vl_LigneEtatCivil
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsTotal)+"TOTAL"
		ta_ActiviteType{$vl_Lignes}:="ST"
		
		
		
		$vl_Lignes:=$vl_Lignes+1
		tt_ActiviteTitre{$vl_Lignes}:="••Nombre total de refus"
		tt_ActiviteTitre{$vl_Lignes}:="NOMBRE TOTAL DE REFUS"
		ta_ActiviteType{$vl_Lignes}:="T"
		
		$vl_Lignes:=$vl_Lignes+1
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsSsT)+"Refus par le CHRS"
		ta_ActiviteType{$vl_Lignes}:="Ts"
		$vl_Lignes:=$vl_Lignes+1
		$vl_LigneEtatCivil:=0
		For ($ii; $vl_Lignes; vl_LigneEtatCivil+$vl_Lignes-1)
			$vl_LigneEtatCivil:=$vl_LigneEtatCivil+1
			tt_ActiviteTitre{$ii}:=("  "*$vl_BlancsEtCv)+ta_LigneEtatCivil{$vl_LigneEtatCivil}
			ta_ActiviteType{$ii}:="S"
		End for 
		$vl_Lignes:=$vl_Lignes+vl_LigneEtatCivil
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsTotal)+"TOTAL"
		ta_ActiviteType{$vl_Lignes}:="ST"
		
		$vl_Lignes:=$vl_Lignes+1
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsSsT)+"Refus par le demandeur"
		ta_ActiviteType{$vl_Lignes}:="Ts"
		$vl_Lignes:=$vl_Lignes+1
		$vl_LigneEtatCivil:=0
		For ($ii; $vl_Lignes; vl_LigneEtatCivil+$vl_Lignes-1)
			$vl_LigneEtatCivil:=$vl_LigneEtatCivil+1
			tt_ActiviteTitre{$ii}:=("  "*$vl_BlancsEtCv)+ta_LigneEtatCivil{$vl_LigneEtatCivil}
			ta_ActiviteType{$ii}:="S"
		End for 
		$vl_Lignes:=$vl_Lignes+vl_LigneEtatCivil
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsTotal)+"TOTAL"
		ta_ActiviteType{$vl_Lignes}:="ST"
		
		$vl_Lignes:=$vl_Lignes+1
		tt_ActiviteTitre{$vl_Lignes}:="•• Nombre total de demandes"
		tt_ActiviteTitre{$vl_Lignes}:="NOMBRE D'ORIENTATIONS DEVENUES AFFECTATIONS"
		ta_ActiviteType{$vl_Lignes}:="T"
		$vl_Lignes:=$vl_Lignes+1
		$vl_LigneEtatCivil:=0
		For ($ii; $vl_Lignes; vl_LigneEtatCivil+$vl_Lignes-1)
			$vl_LigneEtatCivil:=$vl_LigneEtatCivil+1
			tt_ActiviteTitre{$ii}:=("  "*$vl_BlancsEtCv)+ta_LigneEtatCivil{$vl_LigneEtatCivil}
			ta_ActiviteType{$ii}:="S"
		End for 
		$vl_Lignes:=$vl_Lignes+vl_LigneEtatCivil
		tt_ActiviteTitre{$vl_Lignes}:=(" "*$vl_BlancsTotal)+"TOTAL"
		ta_ActiviteType{$vl_Lignes}:="ST"
		
		
	: ($1=2)
		For ($ii; 1; Size of array:C274(tt_ActiviteTitre))
			tl_ActiviteFiches{$ii}:=0
			tl_ActiviteEtatcivil{$ii}:=0
			tl_ActivitePersonnes{$ii}:=0
		End for 
		
		
	: ($1=3)
		tl_ActiviteFiches{9}:=0
		tl_ActiviteFiches{19}:=0
		tl_ActiviteFiches{28}:=0
		tl_ActiviteFiches{38}:=0
		tl_ActiviteFiches{47}:=0
		tl_ActiviteFiches{56}:=0
		
		For ($ii; 1; Size of array:C274(tt_ActiviteTitre))
			Case of 
				: ($ii>1) & ($ii<9)
					tl_ActiviteFiches{9}:=tl_ActiviteFiches{9}+tl_ActiviteFiches{$ii}
					tl_ActiviteEtatcivil{9}:=tl_ActiviteEtatcivil{9}+tl_ActiviteEtatcivil{$ii}
					tl_ActivitePersonnes{9}:=tl_ActivitePersonnes{9}+tl_ActivitePersonnes{$ii}
					
				: ($ii>11) & ($ii<19)
					tl_ActiviteFiches{19}:=tl_ActiviteFiches{19}+tl_ActiviteFiches{$ii}
					tl_ActiviteEtatcivil{19}:=tl_ActiviteEtatcivil{19}+tl_ActiviteEtatcivil{$ii}
					tl_ActivitePersonnes{19}:=tl_ActivitePersonnes{19}+tl_ActivitePersonnes{$ii}
					
				: ($ii>20) & ($ii<28)
					tl_ActiviteFiches{28}:=tl_ActiviteFiches{28}+tl_ActiviteFiches{$ii}
					tl_ActiviteEtatcivil{28}:=tl_ActiviteEtatcivil{28}+tl_ActiviteEtatcivil{$ii}
					tl_ActivitePersonnes{28}:=tl_ActivitePersonnes{28}+tl_ActivitePersonnes{$ii}
					
				: ($ii>30) & ($ii<38)
					tl_ActiviteFiches{38}:=tl_ActiviteFiches{38}+tl_ActiviteFiches{$ii}
					tl_ActiviteEtatcivil{38}:=tl_ActiviteEtatcivil{38}+tl_ActiviteEtatcivil{$ii}
					tl_ActivitePersonnes{38}:=tl_ActivitePersonnes{38}+tl_ActivitePersonnes{$ii}
					
				: ($ii>39) & ($ii<47)
					tl_ActiviteFiches{47}:=tl_ActiviteFiches{47}+tl_ActiviteFiches{$ii}
					tl_ActiviteEtatcivil{47}:=tl_ActiviteEtatcivil{47}+tl_ActiviteEtatcivil{$ii}
					tl_ActivitePersonnes{47}:=tl_ActivitePersonnes{47}+tl_ActivitePersonnes{$ii}
					
					
				: ($ii>48) & ($ii<56)
					tl_ActiviteFiches{56}:=tl_ActiviteFiches{56}+tl_ActiviteFiches{$ii}
					tl_ActiviteEtatcivil{56}:=tl_ActiviteEtatcivil{56}+tl_ActiviteEtatcivil{$ii}
					tl_ActivitePersonnes{56}:=tl_ActivitePersonnes{56}+tl_ActivitePersonnes{$ii}
					
					
			End case 
		End for 
		
		
	: ($1=5)
		// i_Message ("RAZ…")
		C_BOOLEAN:C305($B_Dummy)
		$B_Dummy:=P_ActiviteEnCours(2)
		// i_MessageSeul ("Recherche…")
		
		C_DATE:C307(D_Date; D_Date2)
		If (Application type:C494#4D Server:K5:6)
			D_Date:=[DiaLogues:3]DL_Date:2
			D_Date2:=[DiaLogues:3]DL_Date2:8
		End if 
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=D_Date; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=D_Date2; *)
		//CHERCHER([HeberGement]; & ;[HeberGement]HG_Cloturée=Vrai;*)
		If (rReports=0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
		End if 
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		MultiSoc_Filter(->[HeberGement:5])
		
		MultiSoc_Filter(->[HeberGement:5])
		
		P_HébergementCritèresCentre2
		
		$vl_Fiches:=Records in selection:C76([HeberGement:5])
		//i_MessageSeul ("Tri…")
		
		If ($vl_Fiches>0)
			
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FamClé:104; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FamChef:103; <; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
			
			
			//FIRST RECORD([HeberGement])
			$vl_RéfHB:=[HeberGement:5]HG_HB_ID:19
			$va_EtCivil:=[HeberGement:5]HG_EtatCivil:20
			$va_FamCle:=[HeberGement:5]HG_FamClé:104
			$va_FamChef:=[HeberGement:5]HG_FamChef:103
			$vl_LC_ID:=[HeberGement:5]HG_LC_ID:61
			
			$vl_Jours:=0
			$vl_JoursFamille:=0
			$kk:=0
			
			If (Application type:C494#4D Server:K5:6)
				C_LONGINT:C283($L_ref)
				$L_ref:=4D_Progression_Open("")
			End if 
			
			Repeat 
				$kk:=$kk+1
				//i_MessageSeul ("Calcul : "+String($vl_Fiches)+"/"+String($kk))
				
				If (Application type:C494#4D Server:K5:6)
					If ((($kk%30)=0))
						
						// la propriete STOP
						// on ne la met pas ou on met -1
						// 1 l'utilisateur a cliqué STOP
						// 2 est la valeur au demarrage
						
						C_OBJECT:C1216($O_Progression)
						OB SET:C1220($O_Progression; "progress ref"; $L_ref; "progress titel"; "Transfert des actions"; "progress message"; "Calcul... "+String:C10($kk)+"/"+String:C10($vl_Fiches); "progress compteur"; $kk; "progress max"; $vl_Fiches; "progress stop"; -1)
						4D_Progression_Send(->$O_Progression)
					End if 
				End if 
				
				
				$va_EtCv:=F_EtatCicil_Code([HeberGement:5]HG_EtatCivil:20)
				$vl_TrancheLigne:=0
				Case of 
					: ($va_EtCv="HS")  //HOMME SEUL
						$vl_TrancheLigne:=1
					: ($va_EtCv="FS")  //FEMME SEULE
						$vl_TrancheLigne:=2
					: ($va_EtCv="HC") | ($va_EtCv="FC")  //COUPLES
						$vl_TrancheLigne:=3
					: ($va_EtCv="HE@")  //HOMME AVEC ENFANTS
						$vl_TrancheLigne:=4
					: ($va_EtCv="FE@")  //FEMME AVEC ENFANTS            
						$vl_TrancheLigne:=5
					: ($va_EtCv="HF@") | ($va_EtCv="FF@")  //FAMILLES
						$vl_TrancheLigne:=6
					: ($va_EtCv="FP") | ($va_EtCv="HP")  //ENFANTS
						$vl_TrancheLigne:=7
				End case 
				
				If ($vl_RéfHB=[HeberGement:5]HG_HB_ID:19)
					$vb_OKNewPersonne:=($kk=1)
					If ($kk=1)
						$vb_OKNewPersonne2:=True:C214
					Else 
						If ($vl_LC_ID=[HeberGement:5]HG_LC_ID:61)
							$vb_OKNewPersonne2:=False:C215
						Else 
							$vb_OKNewPersonne2:=True:C214
							$vl_LC_ID:=[HeberGement:5]HG_LC_ID:61
						End if 
					End if 
					$vl_Jours:=$vl_Jours+1
				Else 
					$vb_OKNewPersonne:=True:C214
					$vb_OKNewPersonne2:=True:C214
					$vl_Jours:=1
					$vl_RéfHB:=[HeberGement:5]HG_HB_ID:19
					$va_FamChef:=[HeberGement:5]HG_FamChef:103
					$vl_LC_ID:=[HeberGement:5]HG_LC_ID:61
				End if 
				
				
				
				
				If ($va_FamCle=[HeberGement:5]HG_FamClé:104)
					$vb_OKNewFamille:=($kk=1)
				Else 
					$vb_OKNewFamille:=True:C214
					$va_FamCle:=[HeberGement:5]HG_FamClé:104
				End if 
				
				$vl_Lignes:=$vl_TrancheLigne+1  //•••••••••      
				
				If ($vl_Lignes>1)
					//•• 1 •• NOMBRE TOTAL DE DEMANDES
					//  Si (F_ActiviteTypeCentre ("0a49+115";[HeberGement]HG_CentreNom))
					tl_ActiviteFiches{$vl_Lignes}:=tl_ActiviteFiches{$vl_Lignes}+1
					tl_ActivitePersonnes{$vl_Lignes}:=tl_ActivitePersonnes{$vl_Lignes}+Num:C11($vb_OKNewPersonne)
					If (($vl_TrancheLigne>=1) & ($vl_TrancheLigne<=2))
						tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewPersonne)
					End if 
					If (($vl_TrancheLigne>=3) & ($vl_TrancheLigne<=6))
						tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewFamille)
					End if 
					//  Fin de si   `•• 1 FIN•• NOMBRE TOTAL DE DEMANDES
					
					If ([HeberGement:5]HG_Cloturée:67)
						
						If ([HeberGement:5]HG_AutreSolutio:88=<>va_T_RefusAFFECTE)
							//•• 4 •• NOMBRE D'ORIENTATIONS DEVENUES AFFECTATIONS         
							If (F_ActiviteTypeCentre("0a49-40+115"; [HeberGement:5]HG_CentreNom:62))
								$vl_Lignes:=$vl_TrancheLigne+48  //••••$vl_Lignes•••••      
								tl_ActiviteFiches{$vl_Lignes}:=tl_ActiviteFiches{$vl_Lignes}+1
								tl_ActivitePersonnes{$vl_Lignes}:=tl_ActivitePersonnes{$vl_Lignes}+Num:C11($vb_OKNewPersonne2)
								If (($vl_TrancheLigne>=1) & ($vl_TrancheLigne<=2))
									tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewPersonne2)
								End if 
								If (($vl_TrancheLigne>=3) & ($vl_TrancheLigne<=6))
									tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewFamille)
								End if 
								
							End if 
						End if   //•• 4 FIN•• NOMBRE D'ORIENTATIONS DEVENUES AFFECTATIONS 
						
						$vl_Lignes:=$vl_TrancheLigne+1  //••••$vl_Lignes•••••    
						
						//•• 2 ••  NOMBRE TOTAL DE DEMANDES TRAITEES
						
						If (F_ActiviteTypeCentre("40+115"; [HeberGement:5]HG_CentreNom:62))
							//•• 2.1 •• ORIENTATION       
							$vl_Lignes:=$vl_Lignes+10  //••••$vl_Lignes•••••          
							tl_ActiviteFiches{$vl_Lignes}:=tl_ActiviteFiches{$vl_Lignes}+1
							tl_ActivitePersonnes{$vl_Lignes}:=tl_ActivitePersonnes{$vl_Lignes}+Num:C11($vb_OKNewPersonne2)
							If (($vl_TrancheLigne>=1) & ($vl_TrancheLigne<=2))
								tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewPersonne2)
							End if 
							If (($vl_TrancheLigne>=3) & ($vl_TrancheLigne<=6))
								tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewFamille)
							End if 
						Else 
							If (F_ActiviteTypeCentre("0a49-40"; [HeberGement:5]HG_CentreNom:62))
								//•• 2.2 •• AFFECTATION       
								$vl_Lignes:=$vl_Lignes+19  //••••$vl_Lignes•••••      
								tl_ActiviteFiches{$vl_Lignes}:=tl_ActiviteFiches{$vl_Lignes}+1
								tl_ActivitePersonnes{$vl_Lignes}:=tl_ActivitePersonnes{$vl_Lignes}+Num:C11($vb_OKNewPersonne2)
								If (($vl_TrancheLigne>=1) & ($vl_TrancheLigne<=2))
									tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewPersonne2)
								End if 
								If (($vl_TrancheLigne>=3) & ($vl_TrancheLigne<=6))
									tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewFamille)
								End if 
							End if 
						End if   //•• 2 FIN ••  NOMBRE TOTAL DE DEMANDES TRAITEES
						
					Else   //• Non clôturé
						//••  NOMBRE TOTAL DE REFUS          
						$vb_OK:=True:C214
						Case of 
							: ([HeberGement:5]HG_AutreSolutio:88="")
								$vb_OK:=False:C215
							: ([HeberGement:5]HG_AutreSolutio:88=<>va_T_RefusCHRS)  //•REFUS par le CHRS•
								$vl_Lignes:=$vl_Lignes+29  //••••$vl_Lignes•••••   
							: ([HeberGement:5]HG_AutreSolutio:88=<>va_T_RefusDEMANDEUR)  //•REFUS par le DEMANDEUR•          
								$vl_Lignes:=$vl_Lignes+38  //••••$vl_Lignes•••••   
							Else 
								$vb_OK:=False:C215
						End case 
						
						If ($vb_OK)
							tl_ActiviteFiches{$vl_Lignes}:=tl_ActiviteFiches{$vl_Lignes}+1
							tl_ActivitePersonnes{$vl_Lignes}:=tl_ActivitePersonnes{$vl_Lignes}+Num:C11($vb_OKNewPersonne)
							If (($vl_TrancheLigne>=1) & ($vl_TrancheLigne<=2))
								tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewPersonne)
							End if 
							If (($vl_TrancheLigne>=3) & ($vl_TrancheLigne<=6))
								tl_ActiviteEtatcivil{$vl_Lignes}:=tl_ActiviteEtatcivil{$vl_Lignes}+Num:C11($vb_OKNewFamille)
							End if 
							
						End if 
						
					End if   //•([HeberGement]HG_Cloturée)
				End if   //••Si($vl_Lignes>1)
				
				
				
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
			
			If (Application type:C494#4D Server:K5:6)
				4D_Progression_Close($L_ref)
			End if 
			
			C_BOOLEAN:C305($B_Dummy)
			$B_Dummy:=P_ActiviteEnCours(3)
			
			
		End if 
		CLOSE WINDOW:C154
		
	: ($1=6)
		$vt_Texte:=""
		If (Size of array:C274(tt_ActiviteTitre)>0)
			$h_RefDoc:=Create document:C266("")
			If (OK=1)
				USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
				
				i_Message("Export en cours …")
				$vt_Texte:="Titre"+<>va_TAB+"Nombre de fiches"+<>va_TAB+"Nombre de ménages"+<>va_TAB+"Nombre de personnes "+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
				
				For ($ii; 1; Size of array:C274(tt_ActiviteTitre))
					$vt_Texte:=tt_ActiviteTitre{$ii}+<>va_TAB+String:C10(tl_ActiviteFiches{$ii})+<>va_TAB+String:C10(tl_ActiviteEtatcivil{$ii})+<>va_TAB+String:C10(tl_ActivitePersonnes{$ii})+<>va_CR
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
				End for 
				
				USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
				CLOSE DOCUMENT:C267($h_RefDoc)
				
				CLOSE WINDOW:C154
			End if 
		End if 
		
End case 
