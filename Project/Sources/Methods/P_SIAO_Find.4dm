//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAO_Find
//{          Mercredi 1 decembre 2010 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

CREATE EMPTY SET:C140([SIAO:50]; "E_SIAO_A")
CREATE EMPTY SET:C140([SIAO:50]; "E_SIAO_B")

C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215
If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
		QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Date:2=[DiaLogues:3]DL_Date:2; *)
	Else 
		QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Date:2>=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Date:2<=[DiaLogues:3]DL_Date2:8; *)
	End if 
	$vb_OK:=True:C214
End if 

If ([DiaLogues:3]DL_LibelléN:9>"")
	If ($vb_OK)
		QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demandeur:20=([DiaLogues:3]DL_LibelléN:9+"@"); *)
	Else 
		QUERY:C277([SIAO:50]; [SIAO:50]Si_Demandeur:20=([DiaLogues:3]DL_LibelléN:9+"@"); *)
	End if 
	$vb_OK:=True:C214
End if 


Case of 
	: (rAn1=1) & (rAn2=1)
	: (rAn1=0) & (rAn2=0)
	: (rAn1=0) & (rAn2=1)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_DemandeAnnulee_Date:30=!00-00-00!; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_DemandeAnnulee_Date:30=!00-00-00!; *)
		End if 
		$vb_OK:=True:C214
	: (rAn1=1) & (rAn2=0)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_DemandeAnnulee_Date:30>!00-00-00!; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_DemandeAnnulee_Date:30>!00-00-00!; *)
		End if 
		$vb_OK:=True:C214
End case 

Case of 
	: (trans1=1) & (trans2=1)
	: (trans1=0) & (trans2=0)
	: (trans1=1) & (trans2=0)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Trans_Type:34=True:C214; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Trans_Type:34=True:C214; *)
		End if 
		$vb_OK:=True:C214
	: (trans1=0) & (trans2=1)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Trans_Type:34=False:C215; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Trans_Type:34=False:C215; *)
		End if 
		$vb_OK:=True:C214
End case 


If (Ferm1=0)
	If ($vb_OK)
		QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Fermeture:46=!00-00-00!; *)
	Else 
		QUERY:C277([SIAO:50]; [SIAO:50]Si_Fermeture:46=!00-00-00!; *)
	End if 
	$vb_OK:=True:C214
End if 


Case of 
	: (Dem1=1) & (Dem2=1) & (Dem3=3)
		
	: (Dem1=0) & (Dem2=0) & (Dem3=0)
		
	: (Dem1=1) & (Dem2=0) & (Dem3=0)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=1; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=1; *)
		End if 
		$vb_OK:=True:C214
	: (Dem1=0) & (Dem2=1) & (Dem3=0)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=2; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=2; *)
		End if 
		$vb_OK:=True:C214
	: (Dem1=0) & (Dem2=0) & (Dem3=1)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=3; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=3; *)
		End if 
		$vb_OK:=True:C214
		
	: (Dem1=1) & (Dem2=1) & (Dem3=0)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=1; *)
			QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=2; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=1; *)
			QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=2; *)
		End if 
		$vb_OK:=True:C214
	: (Dem1=1) & (Dem2=0) & (Dem3=1)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=1; *)
			QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=3; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=1; *)
			QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=3; *)
		End if 
		$vb_OK:=True:C214
		
	: (Dem1=0) & (Dem2=1) & (Dem3=1)
		If ($vb_OK)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=2; *)
			QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=3; *)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=2; *)
			QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=3; *)
		End if 
		$vb_OK:=True:C214
		
End case 


If ($vb_OK)
	QUERY:C277([SIAO:50])
	MultiSoc_Filter(->[SIAO:50])
End if 


// 1 ------------- [SIAO]

// ici on cherche dans selection
//Statut de la demande
P_HébergementCritèresFind(->[SIAO:50]; ->[SIAO:50]Si_Etat_Type:41; -><>ta_SIAOREC_Statut; -><>te_SIAOREC_Statut)
//Site d'accueil
P_HébergementCritèresFind(->[SIAO:50]; ->[SIAO:50]Si_OrigineSiteAccueil_ID:19; -><>tl_SIAOREC_SitAccueil; -><>te_SIAOREC_SitAccueil)
//SIAO Competent
P_HébergementCritèresFind(->[SIAO:50]; ->[SIAO:50]Si_Trans_Competent:35; -><>ta_SIAOREC_Competent; -><>te_SIAOREC_Competent)
//référent
P_HébergementCritèresFind(->[SIAO:50]; ->[SIAO:50]Si_ReferentPermanencier:44; -><>ta_SIAOREC_Referent; -><>te_SIAOREC_Referent)

If (1=1)  // debug
	For ($i; 9; 15)
		Case of 
			: ($i=9)  // Logement souhaité 1, 2, 3
				$P_Field:=->[SIAO:50]Si_Log_Souhaite1:22
				$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter1
				$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter1
			: ($i=10)
				$P_Field:=->[SIAO:50]Si_Log_Souhaite2:23
				$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter2
				$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter2
			: ($i=11)
				$P_Field:=->[SIAO:50]Si_Log_Souhaite3:24
				$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter3
				$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter3
			: ($i=12)  // 12 Logement adapté
				$P_Field:=->[SIAO:50]Si_Log_Adapte:25
				$P_Tableau_cible_A:=-><>ta_SIAOREC_LogAdapte
				$P_Tableau_cible_E:=-><>te_SIAOREC_LogAdapte
			: ($i=13)  // Type d’accompagnement souhaite 1, 2, 3
				$P_Field:=->[SIAO:50]Si_Ac_Souhaite1:26
				$P_Tableau_cible_A:=-><>ta_SIAOREC_TypeAccS1
				$P_Tableau_cible_E:=-><>te_SIAOREC_TypeAccS1
			: ($i=14)
				$P_Field:=->[SIAO:50]Si_Ac_Souhaite2:27
				$P_Tableau_cible_A:=-><>ta_SIAOREC_TypeAccS2
				$P_Tableau_cible_E:=-><>te_SIAOREC_TypeAccS2
			: ($i=15)
				$P_Field:=->[SIAO:50]Si_Ac_Souhaite3:28
				$P_Tableau_cible_A:=-><>ta_SIAOREC_TypeAccS3
				$P_Tableau_cible_E:=-><>te_SIAOREC_TypeAccS3
			Else 
				TRACE:C157
		End case 
		// cherche dans selection !!
		P_HébergementCritèresFind(->[SIAO:50]; $P_Field; $P_Tableau_cible_A; $P_Tableau_cible_E)
	End for 
End if   // debug
CREATE SET:C116([SIAO:50]; "E_SIAO_A")


// 2 ------------- [SIAO_Personnes]

//CREATE EMPTY SET([SIAO_Personnes];"E_SIAO_B")
RELATE MANY SELECTION:C340([SIAO_Personnes:51]Sp_SIAO_ID:2)
For ($i; 1; 5)
	
	Case of 
		: ($i=1)
			$B_Trouve:=P_SIAOCritèresFind(1; -><>ta_SIAOREC_EtCv; -><>te_SIAOREC_EtCv; ->[SIAO_Personnes:51]; ->[SIAO_Personnes:51]Sp_EtatCivil:8)
			QUERY SELECTION:C341([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7=1)
		: ($i=2)
			$B_Trouve:=P_SIAOCritèresFind(1; -><>ta_SIAOREC_NeLeLieu; -><>te_SIAOREC_NeLeLieu; ->[SIAO_Personnes:51]; ->[SIAO_Personnes:51]Sp_Lieu_de_naissance_Ville:17)
		: ($i=3)
			$B_Trouve:=P_SIAOCritèresFind(1; -><>ta_SIAOREC_Nationalite; -><>te_SIAOREC_Nationalite; ->[SIAO_Personnes:51]; ->[SIAO_Personnes:51]Sp_Nationalite:23)
		: ($i=4)
			$B_Trouve:=P_SIAOCritèresFind(1; -><>ta_SIAOREC_CasSpec; -><>te_SIAOREC_CasSpec; ->[SIAO_Personnes:51]; ->[SIAO_Personnes:51]Sp_CasSpecific:38)
		: ($i=5)
			If (ve_RecAge=1)
				QUERY SELECTION:C341([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Date_de_naissance:14>=vd_RecAgeDebut; *)
				QUERY SELECTION:C341([SIAO_Personnes:51];  & ; [SIAO_Personnes:51]Sp_Date_de_naissance:14<=vd_RecAgeFin)
			End if 
		Else 
			TRACE:C157
	End case 
	
	//CREATE SET([SIAO_Personnes];"E_SIAO_C")
	//UNION("E_SIAO_C";"E_SIAO_B";"E_SIAO_B")
End for 
//CLEAR SET("E_SIAO_C")
//USE SET("E_SIAO_B")
//CLEAR SET("E_SIAO_B")



ARRAY LONGINT:C221($rL_ID; 0)
SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_SIAO_ID:2; $rL_ID)
QUERY WITH ARRAY:C644([SIAO:50]Si_RéférenceID:1; $rL_ID)
CREATE SET:C116([SIAO:50]; "E_SIAO_B")
INTERSECTION:C121("E_SIAO_A"; "E_SIAO_B"; "E_SIAO_A")
CLEAR SET:C117("E_SIAO_B")




// 3 -------------[SIAO_Situations]
If (1=1)
	RELATE MANY SELECTION:C340([SIAO_Situations:52]Ss_SIAO_ID:2)
	CREATE SET:C116([SIAO_Situations:52]; "all_situations")
	
	// Certains enregistrements qui n'ont pas été double cliqué
	// n'ont pas d'enregistrement dans [SIAO_Situations]
	// Il faut les garder dans la selection de [SIAO]
	USE SET:C118("E_SIAO_A")
	ARRAY LONGINT:C221($rL_ID; 0)
	SELECTION TO ARRAY:C260([SIAO:50]Si_RéférenceID:1; $rL_ID)
	
	CREATE EMPTY SET:C140([SIAO_Situations:52]; "E_SIAO_B")
	For ($i; 16; 26)
		
		C_LONGINT:C283($L_Rang)
		C_TEXT:C284($T_Theme; $T_sousTheme)
		Case of 
			: ($i=16)
				$T_Theme:=SIAO P4 Situation pro
				$T_sousTheme:="A"
				$L_Rang:=1
				$P_Tableau_cible_A:=-><>ta_SIAOREC_SitProf1
				$P_Tableau_cible_E:=-><>te_SIAOREC_SitProf1
			: ($i=17)
				$T_Theme:=SIAO P4 Situation pro
				$T_sousTheme:="A"
				$L_Rang:=2
				$P_Tableau_cible_A:=-><>ta_SIAOREC_SitProf2
				$P_Tableau_cible_E:=-><>te_SIAOREC_SitProf2
				
				
			: ($i=18)  // Sans situation professionnel 
				$T_Theme:=SIAO P4 Situation pro
				$T_sousTheme:="B"
				$L_Rang:=1
				$P_Tableau_cible_A:=-><>ta_SIAOREC_SanSitProf
				$P_Tableau_cible_E:=-><>te_SIAOREC_SanSitProf
				
			: ($i=19)  // Moyen de locomotion
				$T_Theme:=SIAO P4 Situation pro
				$T_sousTheme:="C"
				$L_Rang:=1
				$P_Tableau_cible_A:=-><>ta_SIAOREC_Locomotion
				$P_Tableau_cible_E:=-><>te_SIAOREC_Locomotion
				
			: ($i=20)  // Ressources 1
				$T_Theme:=SIAO P5 Ressources
				$T_sousTheme:="A"
				$L_Rang:=1
				$P_Tableau_cible_A:=-><>ta_SIAOREC_Ressource
				$P_Tableau_cible_E:=-><>te_SIAOREC_Ressource
				
			: ($i=21)  // Logement ou hébergement actuel 1
				$T_Theme:=SIAO P7 Regard du logement
				$T_sousTheme:="A"
				$L_Rang:=1
				$P_Tableau_cible_A:=-><>ta_SIAOREC_LogActuel
				$P_Tableau_cible_E:=-><>te_SIAOREC_LogActuel
				
			: ($i=22)
				$T_Theme:=SIAO P7 Regard du logement
				$T_sousTheme:="B"
				$L_Rang:=1
				$P_Tableau_cible_A:=-><>ta_SIAOREC_MotifDem1
				$P_Tableau_cible_E:=-><>te_SIAOREC_MotifDem1
			: ($i=23)  // Motif de la demande 1
				$T_Theme:=SIAO P7 Regard du logement
				$T_sousTheme:="B"
				$L_Rang:=2
				$P_Tableau_cible_A:=-><>ta_SIAOREC_MotifDem2
				$P_Tableau_cible_E:=-><>te_SIAOREC_MotifDem2
				
			: ($i=24)  // Proposition d’orientation du SIAO 1 2 3
				$T_Theme:=SIAO P12 Propositions
				$T_sousTheme:="C"
				$L_Rang:=1
				$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter_SIAO1
				$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter_SIAO1
			: ($i=25)
				$T_Theme:=SIAO P12 Propositions
				$T_sousTheme:="C"
				$L_Rang:=2
				$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter_SIAO2
				$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter_SIAO2
			: ($i=26)
				$T_Theme:=SIAO P12 Propositions
				$T_sousTheme:="C"
				$L_Rang:=3
				$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter_SIAO3
				$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter_SIAO3
			Else 
				TRACE:C157
		End case 
		
		USE SET:C118("all_situations")
		$B_Trouve:=P_SIAOCritèresSFind(1; $P_Tableau_cible_A; $P_Tableau_cible_E; ->[SIAO_Situations:52]; ->[SIAO_Situations:52]Ss_Intitule:9; $T_Theme; $T_sousTheme; $L_Rang)
		RELATE ONE SELECTION:C349([SIAO_Situations:52]; [SIAO:50])
		CREATE SET:C116([SIAO:50]; "E_SIAO_B")
		INTERSECTION:C121("E_SIAO_A"; "E_SIAO_B"; "E_SIAO_A")
		
		
	End for 
	
	
	
	If (1=1)
		// retrouver les [SIAO] sans [SIAO_Situations] qui ont été oubliés juste avant
		C_LONGINT:C283($L_Trouve)
		For ($i; Size of array:C274($rL_ID); 1; -1)
			SET QUERY DESTINATION:C396(Vers variable:K19:4; $L_Trouve)
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=$rL_ID{$i})
			MultiSoc_Filter(->[SIAO_Situations:52])
			SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
			If ($L_Trouve=0)
				SET QUERY LIMIT:C395(1)
				QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=$rL_ID{$i})
				MultiSoc_Filter(->[SIAO:50])
				ADD TO SET:C119([SIAO:50]; "E_SIAO_A")
				SET QUERY LIMIT:C395(0)
			End if 
		End for 
	End if 
End if 

// 4 -------------ON TERMINE

USE SET:C118("E_SIAO_A")
CLEAR SET:C117("E_SIAO_A")
CLEAR SET:C117("E_SIAO_B")
CLEAR SET:C117("E_SIAO_C")


vL_NbFiches:=Records in selection:C76([SIAO:50])
If (vL_NbFiches>0)
	P_SIAO_Sort(2)
End if 
vl_SIAO_RefAttestation:=0





//Logement souhaité
If (7=8)
	//avant juste après état civil
	
	//CREATE EMPTY SET([SIAO_Situations];"E_Situation")
	//If (P_SIAOCritèresSFind (1;-><>ta_SIAOREC_Statut;-><>te_SIAOREC_Statut;->[SIAO_Situations];->[SIAO_Situations]Ss_Intitule;ta_SIAO_PageTitre{12};"A"))
	
	//QUERY SELECTION([SIAO_Personnes];[SIAO_Personnes]Sp_Rang=1)
	//SELECTION TO ARRAY([SIAO_Personnes]Sp_SIAO_ID;$tl_ID)
	
	//QUERY WITH ARRAY([SIAO]Si_RéférenceID;$tl_ID)
	//CREATE SET([SIAO];"E_SIAO_B")
	//INTERSECTION("E_SIAO_A";"E_SIAO_B";"E_SIAO_A")
	//Else 
	//CREATE EMPTY SET([SIAO];"E_SIAO_A")
	//End if 
End if 
