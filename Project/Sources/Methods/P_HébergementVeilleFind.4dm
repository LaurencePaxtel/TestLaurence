//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementVeilleFind
//{
//{          Vendredi 23 mars 2000 à 16:02:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($T_String)
C_LONGINT:C283($i_el)
C_BOOLEAN:C305($vb_OK; $stop_b)
C_POINTER:C301($P_Compte_fiche; $P_Compte_cle; $P_Compte_FamCle)  // #20180504-3
C_OBJECT:C1216($table_o; $autreTable_o; $varInfo_o)
C_COLLECTION:C1488($collection_c)

var $hebergement_es; $hebergementB_es : cs:C1710.HeberGementSelection

ARRAY TEXT:C222($rT_Distinct_FamCle; 0)  // #20180504-3
ARRAY TEXT:C222($rT_Distinct_cle; 0)

OBJECT SET VISIBLE:C603(*; "LaDernièreFiche"; (r2=1) | (r5=1))

If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	
	If (rSurDateEcheance=1)
		
		If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_RéservationDateFin:134=[DiaLogues:3]DL_Date:2; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_RéservationDateFin:134>=[DiaLogues:3]DL_Date:2; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_RéservationDateFin:134<=[DiaLogues:3]DL_Date2:8; *)
		End if 
		
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
	Else 
		
		If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=[DiaLogues:3]DL_Date:2; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=[DiaLogues:3]DL_Date2:8; *)
		End if 
		
		libTrancheDate:="Du "+outilsGetLibDate(1; [DiaLogues:3]DL_Date:2)+" "+String:C10(Day of:C23([DiaLogues:3]DL_Date:2))+" "+outilsGetLibDate(2; [DiaLogues:3]DL_Date:2)+" "+String:C10(Year of:C25([DiaLogues:3]DL_Date:2))
		
		If ([DiaLogues:3]DL_Date2:8#!00-00-00!)
			libTrancheDate:=libTrancheDate+" Au "+outilsGetLibDate(1; [DiaLogues:3]DL_Date2:8)+" "+String:C10(Day of:C23([DiaLogues:3]DL_Date2:8))+" "+outilsGetLibDate(2; [DiaLogues:3]DL_Date2:8)+" "+String:C10(Year of:C25([DiaLogues:3]DL_Date2:8))
		End if 
		
	End if 
	
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		: (rJourNuit1=0) & (rJourNuit2=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
	End case 
	
	If ([DiaLogues:3]DL_Libellé:3>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Maraude1_1:10=([DiaLogues:3]DL_Libellé:3+"@"); *)
	End if 
	
	If ([DiaLogues:3]DL_LibelléG:10>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_FamClé:104=[DiaLogues:3]DL_LibelléG:10; *)
	End if 
	
	If ([DiaLogues:3]DL_LibelPlus:6>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_CentreNom:62=([DiaLogues:3]DL_LibelPlus:6+"@"); *)
	End if 
	
	If ([DiaLogues:3]DL_LibelAutre:5>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_CodePostal:14=[DiaLogues:3]DL_LibelAutre:5; *)
	End if 
	
	If ([DiaLogues:3]DL_LibelléN:9>"")
		
		If (vb_RecClé)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=vl_RecCléID; *)
		Else 
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21=([DiaLogues:3]DL_LibelléN:9+"@"); *)
		End if 
		
	End if 
	
	//6/12/011
	If (<>ve_ConsoRegion_Mode=2)  //Base régionale
		If ([DiaLogues:3]DL_LibelléL:11>"")
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Regional_Departement:154=[DiaLogues:3]DL_LibelléL:11; *)
		End if 
	End if 
	//FIN 6/12/011
	
	If (sOr1=1)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Orientation1:58>""; *)
	End if 
	
	If (tLocal=1)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Orientation2:60>""; *)
	End if 
	
	If (rReports=0)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
	End if 
	
	If (w115=1)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=0; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<1000000; *)
	End if 
	If (wLien=1)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_FamClé:104=""; *)
	End if 
	
	//6/10/2010
	If (fFicheNuit=1)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_AttenteHeur:83>=<>vh_T_HeureNuit; *)
	End if 
	//Fin 6/10/2010
	
	Case of 
		: (r1=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_ReferenceID:1#0)
		: (r2=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_EnAttente:64=True:C214)
		: (r3=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Transmis:65=True:C214)
		: (r4=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=False:C215)
		: (r5=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_PriseCharge:66=True:C214)
		: (r6=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
			//: (r7=1)
			//   CHERCHER([HéberGement]; & ;[HéberGement]HG_Status=Vrai)
		: (r8=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_FamChef:103=True:C214)
		: (r9=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_PriseCharge:66=False:C215)
		: (r10=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_FamChef:103=False:C215)
	End case 
	
	MultiSoc_Filter(->[HeberGement:5])
	
	If (r7=1)
		CREATE SET:C116([HeberGement:5]; "$E_LaSel")
		
		ARRAY LONGINT:C221($tl_IDSp; 0)
		
		SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $tl_IDSp)
		QUERY WITH ARRAY:C644([HeBerge:4]HB_ReferenceID:1; $tl_IDSp)
		
		QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Cas1:7=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas1:7=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas2:8=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas3:9=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas4:10=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas5:11=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas6:12=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas7:13=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas8:14=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas9:15=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas10:16=True:C214)
		
		MultiSoc_Filter(->[HeBerge:4])
		
		ARRAY LONGINT:C221($tl_IDSp; 0)
		
		SELECTION TO ARRAY:C260([HeBerge:4]HB_ReferenceID:1; $tl_IDSp)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_HB_ID:19; $tl_IDSp)
		
		If (Records in selection:C76([HeberGement:5])>0)
			CREATE SET:C116([HeberGement:5]; "$E_LesSP")
			INTERSECTION:C121("$E_LaSel"; "$E_LesSP"; "$E_LaSel")
			
			USE SET:C118("$E_LaSel")
		Else 
			REDUCE SELECTION:C351([HeberGement:5]; 0)
		End if 
		
	End if 
	
	//Reservation 23/4/2004  
	If (ve_RecReservation=0)
	Else 
		
		Case of 
			: (ve_RecReservation=1)  //Dernière nuit
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitReste:95=0)
				//   Si (ve_RecResDer1=0) | (ve_RecResDer2=0) | (ve_RecResDer1#ve_RecResDer2)
				//  Sinon 
				//    CHERCHER DANS SELECTION([HeberGement];[HeberGement]HG_NuitTOTAL=ve_RecResDer
				// Fin de si 
				
			: (ve_RecReservation=2)  //Pas dernière nuit      
				
				If (7=8)
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitReste:95>0)
					
					If (ve_RecResPasDer1=0) | (ve_RecResPasDer2=0) | (ve_RecResPasDer1=ve_RecResPasDer2)
					Else 
						QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitenCours:92=ve_RecResPasDer1)
						QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitTOTAL:93=ve_RecResPasDer2)
					End if 
					
				End if 
				
				Case of 
					: ((ve_RecResPasDer1=0) & (ve_RecResPasDer2=0))
						QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitReste:95>0)
					: ((ve_RecResPasDer1>0) & (ve_RecResPasDer2>0))
						QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitenCours:92>=ve_RecResPasDer1)
						QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitTOTAL:93<=ve_RecResPasDer2)
					: ((ve_RecResPasDer1>0) & (ve_RecResPasDer2=0))
						QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitenCours:92=ve_RecResPasDer1)
					: ((ve_RecResPasDer1=0) & (ve_RecResPasDer2>0))
						QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitTOTAL:93=ve_RecResPasDer2)
				End case 
				
			: (ve_RecReservation=3)  //Nombre de nuits restant             
				QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95=ve_RecRes3)
		End case 
		
	End if 
	
	If (ve_RecAge=1)
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24>=vd_RecAgeDebut; *)
		QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_DateNéLe:24<=vd_RecAgeFin)
	End if 
	
	If (<>vb_T_ModeCHRS)
		
		If (wSansFiltre=1)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
		End if 
		
	End if 
	
	//Etat civil  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_EtatCivil:20; -><>ta_VeilEtCiv; -><>te_VeilEtCiv)
	
	//Signalement  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Signalement:12; -><>ta_VeilSglt; -><>te_VeilSglt)
	
	//Groupe  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_FamGroupe:102; -><>ta_VeilGroupe; -><>te_VeilGroupe)
	
	//Autre solution 23/4/2004  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_AutreSolutio:88; -><>ta_VeilAutreSol; -><>te_VeilAutreSol)
	
	//Orientation1 26/7/2004 
	If (<>vb_TransVeille=False:C215)
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Orientation1:58; -><>ta_VeilOrient1; -><>te_VeilOrient1)
	Else 
		//7/10/2010
		P_HébergementCritèresFindPlus(->[HeberGement:5]; ->[HeberGement:5]HG_Orientation1:58; -><>ta_VeilOrient1; -><>te_VeilOrient1)
	End if 
	
	//Orientation2 26/7/2004 
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Orientation2:60; -><>ta_VeilOrient2; -><>te_VeilOrient2)
	
	//Permanencier
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Permanencier:9; -><>ta_VeilPerma; -><>te_VeilPerma)
	
	//Ruptures majeures : 26/7/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_RupMajeur1:40; -><>ta_VeilRupMaj1; -><>te_VeilRupMaj1)
	
	//Ruptures majeures2 : 26/7/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_RupMajeur2:41; -><>ta_VeilRupMaj2; -><>te_VeilRupMaj2)
	
	//Ruptures majeures2 : 26/7/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_RupMajeur3:42; -><>ta_VeilRupMaj3; -><>te_VeilRupMaj3)
	
	// Autre solution suite
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_AutreSolSuite:123; -><>ta_VeilAtSsuite; -><>te_VeilAtSsuite)  // 17/2/17
	
	// Orientation 1 suite
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Orientation1Suite:59; -><>ta_VeilTBOr1suite; -><>te_VeilTBOr1suite)  //17/2/17
	
	//Identité 1 : 25/10/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_PiècesIdté1:31; -><>ta_Veilidt1; -><>te_Veilidt1)
	//Identité 2 : 25/10/2004
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_PiècesIdté2:32; -><>ta_Veilidt2; -><>te_Veilidt2)
	
	//Identité 3 : 25/10/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_PiècesIdté3:33; -><>ta_Veilidt3; -><>te_Veilidt3)
	
	//Distribution 5 : 5/7/2007
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_FamDistri5:116; -><>ta_VeilDistri5; -><>te_VeilDistri5)
	
	//Ressources : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Ressources1:45; -><>ta_VeilRess1; -><>te_VeilRess1)
	
	//Ressources : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Ressources2:46; -><>ta_VeilRess2; -><>te_VeilRess2)
	
	//Ressources : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Ressources3:47; -><>ta_VeilRess3; -><>te_VeilRess3)
	
	//Suivi social : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SuiviSocial1:49; -><>ta_VeilSSoc1; -><>te_VeilSSoc1)
	
	//Suivi social : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SuiviSocial2:50; -><>ta_VeilSSoc2; -><>te_VeilSSoc2)
	
	//Suivi social : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SuiviSocial3:51; -><>ta_VeilSSoc3; -><>te_VeilSSoc3)
	
	//Couverture sociale : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CouvSocial1:53; -><>ta_VeilCSoc1; -><>te_VeilCSoc1)
	
	//Couverture sociale : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CouvSocial2:54; -><>ta_VeilCSoc2; -><>te_VeilCSoc2)
	
	//Couverture sociale : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CouvSocial3:55; -><>ta_VeilCSoc3; -><>te_VeilCSoc3)
	
	//Niveau d'étude : 7/7/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_NiveauEtude:43; -><>ta_VeilNivEt; -><>te_VeilNivEt)
	
	//Temps d'errance : 7/7/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_TempsErrance:34; -><>ta_VeilTpsEr; -><>te_VeilTpsEr)
	
	//Metro : 7/7/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Métro:16; -><>ta_VeilMetro; -><>te_VeilMetro)
	
	//Gare : 12/1/2009
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Gare:15; -><>ta_VeilGare; -><>te_VeilGare)
	
	//Plateforme : 3/2/2009
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Plateforme:139; -><>ta_VeilPlateforme; -><>te_VeilPlateforme)
	
	//Dossier SIAO : 16/1/2012
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_DossierSIAO:164; -><>ta_VeilDosSIAO; -><>te_VeilDosSIAO)
	
	//FamCasSpec : 13/3/2012
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_FamCasSpéc:111; -><>ta_VeilFMCaS; -><>te_VeilFMCaS)
	
	// Modifié par : Scanu Rémy (15/02/2022)
	// Ajout filtre par régulateur
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Régulateur:8; -><>ta_VeilRegulateur; -><>te_VeilRegulateur)
	
	// Modifié par : Scanu Rémy (10/08/2022)
	// Ajout filtre par Réservation provisoire
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_ReservationProvisoire:177; -><>ta_ReservationProvisoire; -><>te_ReservationProvisoire)
	
	// Modifié par : Scanu Rémy (21/10/2022)
	// Ajout filtre par Nationalité
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Nationalité:25; -><>ta_Nationalite; -><>te_Nationalite)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Assistante sociale
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_AssistSocial:87; -><>ta_AssistanteSociale; -><>te_AssistanteSociale)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Code postal 
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CodePostal:14; -><>ta_CodePostal; -><>te_CodePostal)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Coordinateur
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Coordinateur:7; -><>ta_Coordinateur; -><>te_Coordinateur)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Dernier emploi
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_DernierEmplo:37; -><>ta_DernierEmploi; -><>te_DernierEmploi)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Dernier hébéergement
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_DernierHéber:35; -><>ta_DernierHebergement; -><>te_DernierHebergement)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Durée sans emploi
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_DuréSanEmplo:38; -><>ta_DureeSansEmploi; -><>te_DureeSansEmploi)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Genre
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Genre:96; -><>ta_Genre; -><>te_Genre)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Lien
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Lien:18; -><>ta_Lien; -><>te_Lien)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Situation famille
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SituFamille:29; -><>ta_SituationFamille; -><>te_SituationFamille)
	
	// Modifié par : Scanu Rémy (19/12/2022)
	// Ajout filtre par Situation professionnelle
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SituProfess:36; -><>ta_SituationProf; -><>te_SituationProf)
	
	// Modifié par : Scanu Rémy (06/04/2023)
	// Ajout filtre par Emplacement
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Emplacement:17; -><>ta_Emplacement; -><>te_Emplacement)
	
	//Centre : 1/2/2012
	If ([DiaLogues:3]DL_LibelPlus:6="")
		P_HébergementCritèresCentre
	End if 
	
	If (rDossierSIAO=1)
		CREATE SET:C116([HeberGement:5]; "E_Set_HG")
		
		SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $tl_RefHBID)
		QUERY WITH ARRAY:C644([SIAO_Personnes:51]Sp_Personne_ID:3; $tl_RefHBID)
		
		If (Records in selection:C76([SIAO_Personnes:51])>0)
			SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_Personne_ID:3; $tl_RefHBID)
			QUERY WITH ARRAY:C644([HeberGement:5]HG_HB_ID:19; $tl_RefHBID)
			
			CREATE SET:C116([HeberGement:5]; "E_Set_HG2")
			
			INTERSECTION:C121("E_Set_HG"; "E_Set_HG2"; "E_Set_HG")
			USE SET:C118("E_Set_HG")
			
			CLEAR SET:C117("E_Set_HG2")
			CLEAR SET:C117("E_Set_HG")
		Else 
			REDUCE SELECTION:C351([HeberGement:5]; 0)
		End if 
		
	End if 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (28/05/2021)
	// Ajout d'une boite à cocher "Fiche Unique"
	If (rFicheUnique=1)
		$table_o:=Create entity selection:C1512([HeberGement:5])
		$autreTable_o:=$table_o.getSituationUnique()
		
/*
$table_o:=$table_o.orderBy("HG_HB_ID asc, HG_Date desc")
		
$collection_c:=$table_o.distinct("HG_HB_ID")
$autreTable_o:=ds.HeberGement.newSelection()
		
Pour chaque ($enregistrement_o; $table_o)
$pos_el:=$collection_c.indexOf($enregistrement_o.HG_HB_ID)
		
Si ($pos_el#-1)
$autreTable_o.add($enregistrement_o)
$collection_c.remove($pos_el)
Fin de si 
		
Fin de chaque 
*/
		
		USE ENTITY SELECTION:C1513($autreTable_o)
		LOAD RECORD:C52([HeberGement:5])
	End if 
	
	If ((r2=1) | (r5=1))
		
		If (rDernièreF=1)
			
			If (Records in selection:C76([HeberGement:5])>0)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
				
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Der_Référence; [HeberGement:5]HG_Date:4; td_Der_Date; [HeberGement:5]HG_HB_ID:19; tl_Der_HB)
				
				vl_ii:=1
				vd_Der_Date:=!00-00-00!
				vl_Der_HB:=0
				
				Repeat 
					
					Case of 
						: (tl_Der_HB{vl_ii}=vl_Der_HB)
							
							If (td_Der_Date{vl_ii}<=vd_Der_Date)
								DELETE FROM ARRAY:C228(tl_Der_Référence; vl_ii)
								DELETE FROM ARRAY:C228(td_Der_Date; vl_ii)
								DELETE FROM ARRAY:C228(tl_Der_HB; vl_ii)
							End if 
							
						: (tl_Der_HB{vl_ii}#vl_Der_HB)
							vl_Der_HB:=tl_Der_HB{vl_ii}
							vd_Der_Date:=td_Der_Date{vl_ii}
							vl_ii:=vl_ii+1
					End case 
					
					$vb_OK:=(vl_ii>Size of array:C274(tl_Der_Référence))
				Until ($vb_OK)
				
				QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_Der_Référence)
			End if 
			
		End if 
		
	End if 
	
	If (rDernièreF=1) & ((r2=1) | (r5=1))
	Else 
		
		If (rDoublons=1)
			
			If (Records in selection:C76([HeberGement:5])>0)
				// #BS 17/06/16 fix erreur syntaxe order by
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; [HeberGement:5]HG_Date:4; <)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Der_Référence; [HeberGement:5]HG_Date:4; td_Der_Date; [HeberGement:5]HG_HB_ID:19; tl_Der_HB)
				
				ARRAY LONGINT:C221(tl_Der_Nb; 0)
				
				vl_ii:=1
				vl_Der_HB:=0
				
				vd_Der_Date:=!00-00-00!
				
				For (vl_ii; 1; Size of array:C274(tl_Der_Référence))
					
					If (vl_Der_HB=tl_Der_HB{vl_ii})
						vl_jj:=Size of array:C274(tl_Der_Nb)+1
						INSERT IN ARRAY:C227(tl_Der_Nb; vl_jj)
						
						tl_Der_Nb{vl_jj}:=tl_Der_Référence{vl_ii-1}
						vl_jj:=Size of array:C274(tl_Der_Nb)+1
						
						INSERT IN ARRAY:C227(tl_Der_Nb; vl_jj)
						tl_Der_Nb{vl_jj}:=tl_Der_Référence{vl_ii}
					End if 
					
					vl_Der_HB:=tl_Der_HB{vl_ii}
				End for 
				
				If (Size of array:C274(tl_Der_Nb)>0)
					QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_Der_Nb)
					
					ARRAY LONGINT:C221(tl_Der_Nb; 0)
				Else 
					REDUCE SELECTION:C351([HeberGement:5]; 0)
				End if 
				
			End if 
			
		End if 
		
	End if 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (07/05/2021)
	// Ajout filtre nb de fiches cloturées
	If (Num:C11(filtreNbFichesDe_at{filtreNbFichesDe_at})>0) | (Num:C11(filtreNbFichesA_at{filtreNbFichesA_at})>0)
		$table_o:=Create entity selection:C1512([HeberGement:5])
		
		$hebergement_es:=ds:C1482.HeberGement.newSelection()
		$collection_c:=$table_o.distinct("HG_HB_ID")
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (11/05/2021)
		// Ajout d'une barre de progression
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($id_el; $collection_c) Until ($stop_b=True:C214)
			outilsProgressBar(($collection_c.indexOf($id_el)+1)/$collection_c.length; "Recherche en cours...")
			
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$id_el)
			F_Passages(1; 0; True:C214)
			
			For ($i_el; 1; Size of array:C274(tl_PasS_NbNuits))
				
				If (tl_PasS_NbNuits{$i_el}>=Num:C11(filtreNbFichesDe_at{filtreNbFichesDe_at})) & (tl_PasS_NbNuits{$i_el}<=Num:C11(filtreNbFichesA_at{filtreNbFichesA_at}))  // Le nombre de fiches cloturées est dans la bonne tranche
					
					Case of 
						: ([DiaLogues:3]DL_Date:2#!00-00-00!) & ([DiaLogues:3]DL_Date2:8#!00-00-00!)
							
							If (td_PasS_Date1{$i_el}>=[DiaLogues:3]DL_Date:2) & (td_PasS_Date1{$i_el}<=[DiaLogues:3]DL_Date2:8)
								$hebergementB_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date >= :2"; $id_el; td_PasS_Date1{$i_el}).orderBy("HG_Date asc")
								$hebergementB_es:=$hebergementB_es.slice(0; outilsGetNbJour(td_PasS_Date2{$i_el}; td_PasS_Date1{$i_el})+1)
								
								$hebergementB_es:=$hebergementB_es.query("HG_Cloturée = :1"; True:C214)
								$hebergement_es:=$hebergement_es.or($hebergementB_es)
							End if 
							
					End case 
					
				End if 
				
			End for 
			
			$stop_b:=(progressBar_el=0)
		End for each 
		
		outilsProgressBar(1; "arrêt")
		
		$table_o:=$table_o.and($hebergement_es)
		
		USE ENTITY SELECTION:C1513($table_o)
		LOAD RECORD:C52([HeberGement:5])
	End if 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (22/02/2022)
	// Ajout filtre Âge
	If (Num:C11(filtreAgeDe_at{filtreAgeDe_at})>0)
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Age:23>=Num:C11(filtreAgeDe_at{filtreAgeDe_at}))
	End if 
	
	If (Num:C11(filtreAgeA_at{filtreAgeA_at})>0)
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Age:23<=Num:C11(filtreAgeA_at{filtreAgeA_at}))
	End if 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (24/06/2021)
	// Ajout filtre date PEC
	If (vDateAnneeEntreeDu#!00-00-00!)
		QUERY SELECTION BY FORMULA:C207([HeberGement:5]; [HeberGement:5]HG_DateEntree:186>=vDateAnneeEntreeDu)
	End if 
	
	If (vDateAnneeEntreeAu#!00-00-00!)
		QUERY SELECTION BY FORMULA:C207([HeberGement:5]; [HeberGement:5]HG_DateEntree:186<=vDateAnneeEntreeAu)
	End if 
	
	If (vDateDebutPECDu#!00-00-00!)
		QUERY SELECTION BY FORMULA:C207([HeberGement:5]; Date:C102([HeberGement:5]HG_Maraude2_2:99)>=vDateDebutPECDu)
	End if 
	
	If (vDateDebutPECAu#!00-00-00!)
		QUERY SELECTION BY FORMULA:C207([HeberGement:5]; Date:C102([HeberGement:5]HG_Maraude2_2:99)<=vDateDebutPECAu)
	End if 
	
	If (vDateFinPECDu#!00-00-00!)
		QUERY SELECTION BY FORMULA:C207([HeberGement:5]; [HeberGement:5]HG_DateSortie:185>=vDateFinPECDu)
	End if 
	
	If (vDateFinPECAu#!00-00-00!)
		QUERY SELECTION BY FORMULA:C207([HeberGement:5]; [HeberGement:5]HG_DateSortie:185<=vDateFinPECAu)
	End if 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (06/03/2024)
	If (Bool:C1537(Form:C1466.avecInconnu)=False:C215)
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nom:21#"X0@")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nom:21#"Y0@")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nom:21#"Z0@")
	End if 
	
End if 

vr_TotalDistri:=Sum:C1([HeberGement:5]HG_FamDistri5M:122)
vL_NbFiches:=Records in selection:C76([HeberGement:5])

DISTINCT VALUES:C339([HeberGement:5]HG_FamClé:104; $rT_Distinct_FamCle)
RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])

MultiSoc_Filter(->[HeBerge:4])

DISTINCT VALUES:C339([HeBerge:4]HB_Clé:2; $rT_Distinct_cle)
REDUCE SELECTION:C351([HeBerge:4]; 0)

$P_Compte_fiche:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "trouve_nb_fiche")
$P_Compte_cle:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "trouve_nb_cle")
$P_Compte_FamCle:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "trouve_nb_dossier")

$T_String:="Recherche et tri: "+String:C10(vL_NbFiches)+" fiche"+Choose:C955(vL_NbFiches>1; "s"; "")+" "+\
String:C10(Size of array:C274($rT_Distinct_cle))+" personne"+Choose:C955(Size of array:C274($rT_Distinct_cle)>1; "s"; "")+" "+\
String:C10(Size of array:C274($rT_Distinct_FamCle))+" ménage"+Choose:C955(Size of array:C274($rT_Distinct_FamCle)>1; "s"; "")

OBJECT SET TITLE:C194(*; "zone_groupe"; $T_String)

If (vL_NbFiches>0)
	P_HébergementVeilleSort(2)
	
	OBJECT SET ENABLED:C1123(b_VoirPrtL; True:C214)
	OBJECT SET ENABLED:C1123(b_VoirPrt; True:C214)
Else 
	OBJECT SET ENABLED:C1123(b_VoirPrtL; False:C215)
	OBJECT SET ENABLED:C1123(b_VoirPrt; False:C215)
End if 

P_HébergementNotesBt(0)

OBJECT SET ENABLED:C1123(b_ModCléHG; False:C215)
OBJECT SET ENABLED:C1123(b_PrtAct; False:C215)
OBJECT SET ENABLED:C1123(b_PrtActF; False:C215)
OBJECT SET ENABLED:C1123(b_Excuse; False:C215)

// Modifié par : Scanu Rémy (07/11/2022)
If (Form:C1466.footerVar#Null:C1517)
	
	For each ($varInfo_o; Form:C1466.footerVar)
		Formula from string:C1601($varInfo_o.varName+":=0").call()
	End for each 
	
End if 

//TRIER([HeberGement]; [HeberGement]HG_Nom; >; [HeberGement]HG_Date; >)