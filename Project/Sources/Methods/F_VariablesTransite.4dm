//%attributes = {"preemptive":"capable"}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_VariablesTransite
//{
//{          Lundi 29 mars 2004 à 11:07:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)  // Quoi
C_LONGINT:C283($2)  // Lequel
C_BOOLEAN:C305($3)  // Utilisation de la nouvelle méthode de duplication
C_DATE:C307($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)
C_LONGINT:C283($7)

C_LONGINT:C283($ve_Cas)
C_BOOLEAN:C305($vb_OK)

ARRAY OBJECT:C1221($rO_Duplique; 0)

$0:=True:C214

Case of 
	: ($1=0)  //DECLARATIONS
		P_VariablesTransiteInit(0)
	: ($1=1)  //INITIALISATIONS partie Historique
		P_VariablesTransiteInit(1)
	: ($1=2)  //AFFECTATION DES VARIABLES
		C_TEXT:C284(erreurMessageDuplication_t)
		
		If ([DePart2:76]Reference_ID:4#-2900)
			QUERY:C277([DePart2:76]; [DePart2:76]Reference_ID:4=-2900)
			MultiSoc_Filter(->[DePart2:76])
			
			If (Records in selection:C76([DePart2:76])=0)
				CREATE RECORD:C68([DePart2:76])
				MultiSoc_Init_Structure(->[DePart2:76])
				
				[DePart2:76]Reference_ID:4:=-2900
				[DePart2:76]Label:3:="tous les champs duplicables"
				SAVE RECORD:C53([DePart2:76])
			End if 
		End if 
		
		If ($3=True:C214)
			If (OB Is defined:C1231([DePart2:76]Proprietes_Nv:6; "duplique"))
				OB GET ARRAY:C1229([DePart2:76]Proprietes_Nv:6; "duplique"; $rO_Duplique)
			End if 
			
		Else 
			If (OB Is defined:C1231([DePart2:76]Proprietes:2; "duplique"))
				OB GET ARRAY:C1229([DePart2:76]Proprietes:2; "duplique"; $rO_Duplique)
			End if 
		End if 
		
		// Modifié par : Scanu Rémy (24/01/2024)
		If (Size of array:C274($rO_Duplique)>0)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_AssistSocial:87; ->va_IDT_AsSo)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_CodePostal:14; ->va_IDT_CP)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Gare:15; ->va_IDT_Gare)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Métro:16; ->va_IDT_Metr)
			
			// Modified by: Kevin HASSAL (02/08/2019)
			// Duplication HG_Signalement
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Signalement:12; ->va_IDT_SG)
			
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Plateforme:139; ->va_IDT_Plateforme)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_PlateformeCentre:140; ->va_IDT_PlateformeCentre)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Trans_DDASS:141; ->vb_IDT_TransDDASS)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Trans_RéférenceID:142; ->vl_IDT_TransRéf)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Trans_FicheNuméro:143; ->va_IDT_TransFiche)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Trans_HB_ID:144; ->vl_IDT_Trans_HBID)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Trans_LC_ID:145; ->vl_IDT_Trans_CLD)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Trans_CentreNom:146; ->va_IDT_TransCentre)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Trans_FamClé:147; ->va_IDT_TransFamClé)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Trans_Plateforme:148; ->va_IDT_TransPlateforme)
			
			va_IDT_Typ2:=""  // Laisser en l'état   // #20180530-1
			
			// Modifié par : Scanu Rémy (03/11/2022)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_EtatCivil:20; ->va_IDT_Typ1)
			
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Nom:21; ->va_IDT_Nom)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Prénom:22; ->va_IDT_Pré)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_DateNéLe:24; ->vd_IDT_NéLe)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Nationalité:25; ->va_IDT_Nat)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Lien:18; ->va_IDT_Lien)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_SituFamille:29; ->va_IDT_SitF)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_DernierHéber:35; ->va_IDT_DerH)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_TempsErrance:34; ->va_IDT_TpEr)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_SituProfess:36; ->va_IDT_SitP)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_DernierEmplo:37; ->va_IDT_DerE)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_DuréSanEmplo:38; ->va_IDT_DurE)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_NiveauEtude:43; ->va_IDT_NivE)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_PiècesIdté1:31; ->va_IDT_Pt1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_PiècesIdté2:32; ->va_IDT_Pt2)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_PiècesIdté3:33; ->va_IDT_Pt3)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_SuiviSocial1:49; ->va_IDT_Sv1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_SuiviSocial2:50; ->va_IDT_Sv2)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_SuiviSocial3:51; ->va_IDT_Sv3)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_CouvSocial1:53; ->va_IDT_Cv1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_CouvSocial2:54; ->va_IDT_Cv2)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_CouvSocial3:55; ->va_IDT_Cv3)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_RupMajeur1:40; ->va_IDT_RM1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_RupMajeur2:41; ->va_IDT_RM2)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_RupMajeur3:42; ->va_IDT_RM3)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_RupMajeur1_2:72; ->va_IDT_RM11)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_RupMajeur2_2:73; ->va_IDT_RM21)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_RupMajeur3_2:74; ->va_IDT_RM31)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Ressources1:45; ->va_IDT_RA1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Ressources2:46; ->va_IDT_RA2)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Ressources3:47; ->va_IDT_RA3)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Ressource1_2:75; ->va_IDT_RA11)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Ressource2_2:76; ->va_IDT_RA21)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Ressource3_2:77; ->va_IDT_RA31)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Status:89; ->ve_IDT_St)  //ve_IDT_St:=Num([HeberGement]HG_Status=True)
			
			va_IDT_AutS:=""  // En l'état   // #20180530-1
			va_IDT_AutS2:=""  // En l'état   // #20180530-1
			vb_IDT_ER:=False:C215  // En l'état   // #20180530-1
			vd_IDT_ERDtD:=!00-00-00!  // En l'état   // #20180530-1
			vd_IDT_ERDtF:=!00-00-00!  // En l'état   // #20180530-1
			ve_IDT_ERNoN:=0  // En l'état   // #20180530-1
			ve_IDT_ERTotN:=0  // En l'état   // #20180530-1
			
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamGroupe:102; ->va_IDT_FGrp)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamChef:103; ->vb_IDT_FRes)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamClé:104; ->va_IDT_Ffam)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamCompo:105; ->va_IDT_FCom)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamNbPers:106; ->ve_IDT_FPer)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamNbJour:107; ->ve_IDT_FJou)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamNbChambre:108; ->ve_IDT_FChb)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamPrixJour:109; ->vr_IDT_FPxJ)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamTotal:110; ->vr_IDT_FPxT)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri1:112; ->va_IDT_FDi1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri2:113; ->va_IDT_FDi2)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri3:114; ->va_IDT_FDi3)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri4:115; ->va_IDT_FDi4)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri5:116; ->va_IDT_FDi5)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamCasSpéc:111; ->va_IDT_FCSp)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamCompoVar:117; ->va_IDT_Fvar)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri1M:118; ->vr_IDT_FDi1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri2M:119; ->vr_IDT_FDi2)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri3M:120; ->vr_IDT_FDi3)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri4M:121; ->vr_IDT_FDi4)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_FamDistri5M:122; ->vr_IDT_FDi5)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_GestionCentreNuit:133; ->va_IDT_CtrJN)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Maraude1_1:10; ->va_IDT_Mar)
			
			//================================
			// Added by: Kevin HASSAL (15/02/2020)
			//================================
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_DateEntree:186; ->va_IDT_Mar_1_2)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Maraude2_1:98; ->va_IDT_Mar_2_1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Maraude2_2:99; ->va_IDT_Mar_2_2)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Maraude3_1:100; ->va_IDT_Mar_3_1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_DateSortie:185; ->va_IDT_Mar_3_2)
			
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Coordinateur:7; ->va_IDT_Coo)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Régulateur:8; ->va_IDT_Rég)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Permanencier:9; ->va_IDT_Per)
			
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_SignalCentre:13; ->va_IDT_SGct)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Emplacement:17; ->va_IDT_Emp)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Orientation1:58; ->va_IDT_Or1)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Orientation1Suite:59; ->va_IDT_Or1Suite)
			
			//================================
			
			$vb_OK:=($2=1)  // A l'écran
			
			If ($vb_OK)
				vl_IDT_Old:=[HeberGement:5]HG_ReferenceID:1
				ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
				
				x_IDTG_1:=Num:C11([HeberGement:5]HG_Genre:96=False:C215)
				x_IDTG_2:=Num:C11([HeberGement:5]HG_Genre:96=True:C214)
				
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Orientation2:60; ->va_IDT_Or2)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_AutreSolutio:88; ->va_IDT_AutS)
			End if 
			
			$vb_OK:=(($2=2) | ($2=3))  // Report En mémoire
			
			If ($vb_OK)
				va_IDT_JN:=Choose:C955([HeberGement:5]HG_Nuit:2; "N"; "J")
				
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_HB_ID:19; ->vl_RéfU_HBB)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Age:23; ->ve_IDT_Age)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Nuit:2; ->vb_IDT_JN)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_UtilisateurP:6; ->va_IDT_Util)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Coordinateur:7; ->va_IDT_Coo)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Régulateur:8; ->va_IDT_Rég)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Permanencier:9; ->va_IDT_Per)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_LS_Signalnt:11; ->va_IDT_SGls)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Signalement:12; ->va_IDT_SG)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_SignalCentre:13; ->va_IDT_SGct)
				
				va_IDT_Or1Suite:=""
				
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_AutreSolutio:88; ->va_IDT_AutS)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_AutreSolSuite:123; ->va_IDT_AutS2)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Orientation1:58; ->va_IDT_Or1)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Orientation2:60; ->va_IDT_Or2)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_LC_ID:61; ->ve_IDT_LCID)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_CentreNom:62; ->va_IDT_LCC)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_CentreARR:63; ->va_IDT_LCA)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_NuitenCours:92; ->ve_IDT_NoN)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_NuitTOTAL:93; ->ve_IDT_TotN)
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Reporté:94; ->va_IDT_TypeReport)
				
				If ([HeberGement:5]HG_ER_Excuse:124)  // Absence excusée
					
					If ([HeberGement:5]HG_ER_NuitReste:129>0)
						Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_ER_Excuse:124; ->vb_IDT_ER)
						Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_ER_DateDébut:125; ->vd_IDT_ERDtD)
						Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_ER_DateFin:126; ->vd_IDT_ERDtF)
						Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_ER_NuitEnCours:127; ->ve_IDT_ERNoN)
						Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_ER_NuitTotal:128; ->ve_IDT_ERTotN)
						Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_AutreSolSuite:123; ->va_IDT_AutS2)
						Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_AutreSolutio:88; ->va_IDT_AutS)
					End if 
					
					If ([HeberGement:5]HG_ER_NuitReste:129=0)
						va_IDT_AutS:=""
						va_IDT_AutS2:=""
					End if 
					
				End if 
				
				Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_ER_Remplaçant:130; ->vb_IDT_Remp)
				
				If ([HeberGement:5]HG_ER_Remplaçant:130)
					Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_ER_RemplaceQuiRéf:131; ->vl_IDT_Remp)
					Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_ER_RemplaceQui:132; ->va_IDT_Remp)
				Else 
					vl_IDT_Remp:=0
					va_IDT_Remp:=""
				End if 
				
			End if 
			
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Flag_DAHO:156; ->vb_IDT_Falg_Daho)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Flag_CapaciteAcces:158; ->vb_IDT_Falg_Capacite)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Flag_FemViolence:157; ->vb_IDT_Falg_Violence)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Flag_LogAutonome:159; ->vb_IDT_Falg_Logement)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Flag_OrientCorrespondant:161; ->vb_IDT_Falg_Orientation)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Flag_Souhait:160; ->vb_IDT_Falg_Souhait)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Flag_RefusParStructure:162; ->vb_IDT_Falg_RefusStrut)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Flag_RefusParDemandeur:163; ->vb_IDT_Falg_RefusPers)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_DossierSIAO:164; ->va_IDT_DossierSIAO)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Type_Demande:165; ->va_IDT_TypeDemande)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Type_Prescripteur:166; ->va_IDT_TypePrescripteur)
			Dupliquer_champ_new_value(->$rO_Duplique; ->[HeberGement:5]HG_Type_de_Place:167; ->va_IDT_TypePlace)
		Else 
			erreurMessageDuplication_t:="Vous devez paramétrer la duplication des champs dans la base de données."
		End if 
		
	: ($1=3)  // CERTAINES INITIALISATIONS
		P_VariablesTransiteInit(3)
	: ($1=4)  // AFFECTATION DES CHAMPS
		$vb_OK:=(($2=2) | ($2=3))  // Report En mémoire ou utilitaire
		
		If ($vb_OK)
			[HeberGement:5]HG_ReferenceID:1:=$5
			[HeberGement:5]HG_Nuit:2:=vb_IDT_JN
			[HeberGement:5]HG_Date:4:=$4
			
			If ($2=2)  // Report En mémoire
				[HeberGement:5]HG_HeureAppel:5:=Current time:C178
			End if 
			
			If ($2=3)  // Report En mémoire utilitaire
				[HeberGement:5]HG_HeureAppel:5:=vd_HeureRéelle
			End if 
			
			vl_Num_HBE:=$6
			[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche(va_IDT_JN; [HeberGement:5]HG_Date:4; vl_Num_HBE)
			
			[HeberGement:5]HG_EnAttente:64:=True:C214
			[HeberGement:5]HG_DateDuJour:82:=Current date:C33
			[HeberGement:5]HG_AttenteHeur:83:=Current time:C178
			[HeberGement:5]HG_Transmis:65:=False:C215
			[HeberGement:5]HG_PriseCharge:66:=False:C215
			[HeberGement:5]HG_Cloturée:67:=False:C215
			
			[HeberGement:5]HG_UtilisateurP:6:=va_IDT_Util
			[HeberGement:5]HG_Coordinateur:7:=va_IDT_Coo
			[HeberGement:5]HG_Régulateur:8:=va_IDT_Rég
			[HeberGement:5]HG_Permanencier:9:=va_IDT_Per
			
			
			[HeberGement:5]HG_HB_ID:19:=vl_RéfU_HBB
		End if 
		
		$vb_OK:=($2=4)  // Groupe
		
		If ($vb_OK)
			// Utilisé uniquement dans le formulaire DL_hebergementGpeNew
/*
[HeberGement]HG_ReferenceID:=vl_RéfU_HG
[HeberGement]HG_Nuit:=(va_JourNuit="N")
[HeberGement]HG_Date:=Date du jour
[HeberGement]HG_HeureAppel:=vd_HeureRéelle
[HeberGement]HG_FicheNuméro:=i_HébérgementNoFiche(va_JourNuit; [HeberGement]HG_Date; vl_Num_HBE)
[HeberGement]HG_DateDuJour:=Date du jour
[HeberGement]HG_EnAttente:=vb_HGGP_Att
[HeberGement]HG_AttenteHeur:=vh_HGGP_AttHeure
[HeberGement]HG_Transmis:=vb_HGGP_Trans
[HeberGement]HG_TransmisHeur:=vh_HGGP_TransHeure
[HeberGement]HG_PriseCharge:=vb_HGGP_PrCh
[HeberGement]HG_PrChargeHeur:=vh_HGGP_PrChHeure
[HeberGement]HG_Cloturée:=vb_HGGP_Clô
[HeberGement]HG_CloturéeHeur:=vh_HGGP_ClôHeure
			
[HeberGement]HG_UtilisateurP:=va_IDT_Util
[HeberGement]HG_Coordinateur:=va_IDT_Coo
[HeberGement]HG_Régulateur:=va_IDT_Rég
[HeberGement]HG_Permanencier:=va_HGGP_Permanencier
			
[HeberGement]HG_HB_ID:=<>tl_GpHBID{$6}
[HeberGement]HG_EtatCivil:=<>ta_GpEtCv{$6}
			
CHERCHER([HeBerge]; [HeBerge]HB_ReferenceID=[HeberGement]HG_HB_ID)
MultiSoc_Filter(->[HeBerge])
			
[HeberGement]HG_Nom:=[HeBerge]HB_Nom
[HeberGement]HG_Prénom:=[HeBerge]HB_Prénom
[HeberGement]HG_DateNéLe:=[HeBerge]HB_DateNéLe
[HeberGement]HG_Genre:=[HeBerge]HG_Genre
[HeberGement]HG_Age:=Uut_HébergéAgePlus(->[HeberGement]HG_DateNéLe; ->[HeberGement]HG_Date)
*/
		Else 
			[HeberGement:5]HG_EtatCivil:20:=va_IDT_Typ1
			[HeberGement:5]HG_Nom:21:=va_IDT_Nom
			[HeberGement:5]HG_Prénom:22:=va_IDT_Pré
			[HeberGement:5]HG_DateNéLe:24:=vd_IDT_NéLe
			[HeberGement:5]HG_Age:23:=ve_IDT_Age
			
			//Bug historique corrigé le 25/05/2005
			[HeberGement:5]HG_Genre:96:=F_EtatCivilGenre(va_IDT_Typ1)
		End if 
		
		$vb_OK:=($2=1)  // A l'écran  
		
		If ($vb_OK)
			[HeberGement:5]HG_LienParenté:26:=vl_IDT_Lier
			[HeberGement:5]HG_Genre:96:=(x_IDTG_2=1)
			[HeberGement:5]HG_Age:23:=Uut_HébergéAgePlus(->[HeberGement:5]HG_DateNéLe:24; ->[HeberGement:5]HG_DateDuJour:82)
			
			//22/12/2008
			[HeberGement:5]HG_Orientation2:60:=va_IDT_Or2
		End if 
		
		$vb_OK:=(($2=2) | ($2=3))  // Report En mémoire ou utilitaire
		
		If ($vb_OK)
			va_Identité:=[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22
			
			[HeberGement:5]HG_NbFicheLiée:79:=ve_IDT_NbFL
			[HeberGement:5]HG_YaFicheLiée:78:=(ve_IDT_NbFL>0)
			
			//*******************************
			If (ve_IDT_NoN<=1)
				[HeberGement:5]HG_Signalement:12:="* Report"
			Else 
				[HeberGement:5]HG_Signalement:12:=va_IDT_SG
			End if 
			//******************************* 
			
			[HeberGement:5]HG_SignalCentre:13:=""
		End if 
		
		$vb_OK:=($2=4)  // Groupe
		
		If ($vb_OK)
			[HeberGement:5]HG_Signalement:12:=va_HGGP_Signalement
			[HeberGement:5]HG_SignalCentre:13:=va_HGGP_SignalCentre
			
			va_IDT_AutS:=va_HGGP_AutreSol1  // L'ancien développeur a créé 2 variables pour la même info. va_HGGP_AutreSol1 pour les groupes
		End if 
		
		[HeberGement:5]HG_AutreSolutio:88:=va_IDT_AutS
		
		[HeberGement:5]HG_AssistSocial:87:=va_IDT_AsSo
		[HeberGement:5]HG_Nationalité:25:=va_IDT_Nat
		[HeberGement:5]HG_CodePostal:14:=va_IDT_CP
		[HeberGement:5]HG_Gare:15:=va_IDT_Gare
		[HeberGement:5]HG_Métro:16:=va_IDT_Metr
		
		// Modified by: Kevin HASSAL (02/08/2019)
		// Activation de la duplication des champs HG_Signalement,HG_SignalCentre 
		[HeberGement:5]HG_Signalement:12:=va_IDT_SG
		[HeberGement:5]HG_SignalCentre:13:=va_IDT_SGct
		
		//10/1/2008
		[HeberGement:5]HG_Plateforme:139:=va_IDT_Plateforme
		//FIN 10/1/2008
		
		//4/11/2008 et le 26/11/2008
		[HeberGement:5]HG_PlateformeCentre:140:=va_IDT_PlateformeCentre
		[HeberGement:5]HG_Trans_DDASS:141:=vb_IDT_TransDDASS
		[HeberGement:5]HG_Trans_RéférenceID:142:=vl_IDT_TransRéf
		[HeberGement:5]HG_Trans_FicheNuméro:143:=va_IDT_TransFiche
		[HeberGement:5]HG_Trans_HB_ID:144:=vl_IDT_Trans_HBID
		[HeberGement:5]HG_Trans_LC_ID:145:=vl_IDT_Trans_CLD
		[HeberGement:5]HG_Trans_CentreNom:146:=va_IDT_TransCentre
		[HeberGement:5]HG_Trans_FamClé:147:=va_IDT_TransFamClé
		[HeberGement:5]HG_Trans_Plateforme:148:=va_IDT_TransPlateforme
		[HeberGement:5]HG_Emplacement:17:=va_IDT_Emp
		[HeberGement:5]HG_Lien:18:=va_IDT_Lien
		[HeberGement:5]HG_SituFamille:29:=va_IDT_SitF
		[HeberGement:5]HG_DernierHéber:35:=va_IDT_DerH
		[HeberGement:5]HG_TempsErrance:34:=va_IDT_TpEr
		[HeberGement:5]HG_SituProfess:36:=va_IDT_SitP
		[HeberGement:5]HG_DernierEmplo:37:=va_IDT_DerE
		[HeberGement:5]HG_NiveauEtude:43:=va_IDT_NivE
		[HeberGement:5]HG_PiècesIdté1:31:=va_IDT_Pt1
		[HeberGement:5]HG_PiècesIdté2:32:=va_IDT_Pt2
		[HeberGement:5]HG_PiècesIdté3:33:=va_IDT_Pt3
		[HeberGement:5]HG_SuiviSocial1:49:=va_IDT_Sv1
		[HeberGement:5]HG_SuiviSocial2:50:=va_IDT_Sv2
		[HeberGement:5]HG_SuiviSocial3:51:=va_IDT_Sv3
		[HeberGement:5]HG_CouvSocial1:53:=va_IDT_Cv1
		[HeberGement:5]HG_CouvSocial2:54:=va_IDT_Cv2
		[HeberGement:5]HG_CouvSocial3:55:=va_IDT_Cv3
		[HeberGement:5]HG_RupMajeur1:40:=va_IDT_RM1
		[HeberGement:5]HG_RupMajeur2:41:=va_IDT_RM2
		[HeberGement:5]HG_RupMajeur3:42:=va_IDT_RM3
		[HeberGement:5]HG_RupMajeur1_2:72:=va_IDT_RM11
		[HeberGement:5]HG_RupMajeur2_2:73:=va_IDT_RM21
		[HeberGement:5]HG_RupMajeur3_2:74:=va_IDT_RM31
		[HeberGement:5]HG_Ressources1:45:=va_IDT_RA1
		[HeberGement:5]HG_Ressources2:46:=va_IDT_RA2
		[HeberGement:5]HG_Ressources3:47:=va_IDT_RA3
		[HeberGement:5]HG_Ressource1_2:75:=va_IDT_RA11
		[HeberGement:5]HG_Ressource2_2:76:=va_IDT_RA21
		[HeberGement:5]HG_Ressource3_2:77:=va_IDT_RA31
		
		// Modifié par : Scanu Rémy (04/10/2022)
		If (Value type:C1509(ve_IDT_St)=Est un entier:K8:5) | (Value type:C1509(ve_IDT_St)=Est un entier long:K8:6)
			[HeberGement:5]HG_Status:89:=(ve_IDT_St=1)
		End if 
		
		If (Value type:C1509(ve_IDT_St)=Est un booléen:K8:9)
			[HeberGement:5]HG_Status:89:=(Bool:C1537(ve_IDT_St)=True:C214)
		End if 
		
		[HeberGement:5]HG_Maraude1_1:10:=va_IDT_Mar  //Placé le 23/2/2009
		
		//================================
		// Added by: Kevin HASSAL (15/02/2020)
		//================================
		[HeberGement:5]HG_DateEntree:186:=va_IDT_Mar_1_2
		[HeberGement:5]HG_Maraude2_1:98:=va_IDT_Mar_2_1
		[HeberGement:5]HG_Maraude2_2:99:=va_IDT_Mar_2_2
		[HeberGement:5]HG_Maraude3_1:100:=va_IDT_Mar_3_1
		[HeberGement:5]HG_DateSortie:185:=va_IDT_Mar_3_2
		
		[HeberGement:5]HG_Coordinateur:7:=va_IDT_Coo
		[HeberGement:5]HG_Régulateur:8:=va_IDT_Rég
		
		// Modifié par : Scanu Rémy (07/10/2021)
		If ([HeberGement:5]HG_Permanencier:9="")
			[HeberGement:5]HG_Permanencier:9:=va_IDT_Per
		End if 
		
		[HeberGement:5]HG_Orientation1:58:=va_IDT_Or1
		[HeberGement:5]HG_Orientation1Suite:59:=va_IDT_Or1Suite
		//================================
		
		$vb_OK:=($2=1)  // A l'écran
		
		If ($vb_OK)
			[HeberGement:5]HG_DuréSanEmplo:38:=va_IDT_DurE
			
		End if 
		
		$vb_OK:=(($2=2) | ($2=3))  // Report En mémoire ou utilitaire
		
		If ($vb_OK)
			[HeberGement:5]HG_DuréSanEmplo:38:=va_IDT_DurE
			[HeberGement:5]HG_AutreSolutio:88:=va_IDT_AutS
			[HeberGement:5]HG_AutreSolSuite:123:=va_IDT_AutS2
			[HeberGement:5]HG_Orientation1:58:=va_IDT_Or1
			[HeberGement:5]HG_Orientation2:60:=va_IDT_Or2
			
			[HeberGement:5]HG_LC_ID:61:=ve_IDT_LCID
			[HeberGement:5]HG_CentreNom:62:=va_IDT_LCC
			[HeberGement:5]HG_CentreARR:63:=va_IDT_LCA
			
			If (ve_IDT_ProlongTotN>0)
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=vl_IDT_ProlongLC)
				MultiSoc_Filter(->[LesCentres:9])
				
				If (Records in selection:C76([LesCentres:9])=1)
					[HeberGement:5]HG_LC_ID:61:=[LesCentres:9]LC_RéférenceID:1
					[HeberGement:5]HG_CentreNom:62:=[LesCentres:9]LC_Nom:4
					[HeberGement:5]HG_CentreARR:63:=[LesCentres:9]LC_Lieu:5
				End if 
				
			End if 
			
			// Partie réservation, dans cette partie intégrer la prolongation
			[HeberGement:5]HG_Réservation:91:=True:C214
			
			If (ve_IDT_ProlongTotN>0)
				[HeberGement:5]HG_NuitenCours:92:=1
				[HeberGement:5]HG_NuitTOTAL:93:=ve_IDT_ProlongTotN
			Else 
				[HeberGement:5]HG_NuitenCours:92:=ve_IDT_NoN+1
				[HeberGement:5]HG_NuitTOTAL:93:=ve_IDT_TotN
			End if 
			
			[HeberGement:5]HG_Reporté:94:=""
			[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
			//06/09/2004
			
			[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
			// Fin Partie réservation
			
			[HeberGement:5]HG_ER_Excuse:124:=False:C215
			[HeberGement:5]HG_ER_NuitEnCours:127:=0
			[HeberGement:5]HG_ER_NuitTotal:128:=0
			[HeberGement:5]HG_ER_NuitReste:129:=0
			
			[HeberGement:5]HG_ER_DateDébut:125:=!00-00-00!
			[HeberGement:5]HG_ER_DateFin:126:=!00-00-00!
			
			[HeberGement:5]HG_ER_Remplaçant:130:=vb_IDT_Remp
			[HeberGement:5]HG_ER_RemplaceQuiRéf:131:=vl_IDT_Remp
			[HeberGement:5]HG_ER_RemplaceQui:132:=va_IDT_Remp
			
			//Si (<>vb_CentreEXC) & (<>va_CentreEXCExc="O"))
			
			//Si (vb_IDT_ER)
			
			//Si ((ve_IDT_ERTotN-ve_IDT_ERNoN)>0)
			//$ve_Cas:=1
			//Sinon 
			//$ve_Cas:=2
			//Fin de si 
			
			//Fin de si 
			
			//Fin de si 
			
			Case of 
				: ($ve_Cas=0)
					[HeberGement:5]HG_Cloturée:67:=True:C214
					
					If ($2=2)  // Report En mémoire
						P_BoolHeureCommute(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
					End if 
					
					If ($2=3)  // Report En mémoire utilitaire
						P_BoolHeureCommuteA(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
					End if 
					
					[HeberGement:5]HG_EnAttente:64:=False:C215
				: ($ve_Cas=1)
					[HeberGement:5]HG_Cloturée:67:=False:C215
					[HeberGement:5]HG_EnAttente:64:=True:C214
					
					If ($2=2)  //Report En mémoire
						P_BoolHeureCommute(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
						
						[HeberGement:5]HG_AttenteHeur:83:=Current time:C178()
					End if 
					
					If ($2=3)  // Report en mémoire utilitaire
						P_BoolHeureCommuteA(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
						[HeberGement:5]HG_AttenteHeur:83:=vd_HeureRéelle
					End if 
					
					[HeberGement:5]HG_ER_Excuse:124:=True:C214
					[HeberGement:5]HG_ER_DateDébut:125:=vd_IDT_ERDtD
					[HeberGement:5]HG_ER_DateFin:126:=vd_IDT_ERDtF
					
					[HeberGement:5]HG_ER_NuitEnCours:127:=ve_IDT_ERNoN+1
					[HeberGement:5]HG_ER_NuitTotal:128:=ve_IDT_ERTotN
					[HeberGement:5]HG_ER_NuitReste:129:=[HeberGement:5]HG_ER_NuitTotal:128-[HeberGement:5]HG_ER_NuitEnCours:127
				: ($ve_Cas=2)
					[HeberGement:5]HG_Cloturée:67:=True:C214
					
					If ($2=2)  // Report En mémoire
						P_BoolHeureCommute(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
					End if 
					
					If ($2=3)  // Report En mémoire utilitaire
						P_BoolHeureCommuteA(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
					End if 
					
					[HeberGement:5]HG_EnAttente:64:=False:C215
			End case 
			
		End if 
		
		$vb_OK:=($2=4)  // Groupe
		
		If ($vb_OK)
			
			[HeberGement:5]HG_DuréSanEmplo:38:=va_IDT_DurE
			[HeberGement:5]HG_Orientation1:58:=va_HGGP_Orientation1
			[HeberGement:5]HG_Orientation2:60:=va_HGGP_Orientation2
			
			[HeberGement:5]HG_Emplacement:17:=va_HGGP_Emplacement  //••9/10/2006
			
			[HeberGement:5]HG_AutreSolutio:88:=va_IDT_AutS
			[HeberGement:5]HG_AutreSolSuite:123:=va_IDT_AutS2
			
			[HeberGement:5]HG_LC_ID:61:=vl_HGGP_LC_ID
			[HeberGement:5]HG_CentreNom:62:=va_HGGP_CentreNom
			[HeberGement:5]HG_CentreARR:63:=va_HGGP_CentreARR
			
			// Partie réservation
			[HeberGement:5]HG_Réservation:91:=vb_HGGP_Réservation
			[HeberGement:5]HG_NuitenCours:92:=1
			[HeberGement:5]HG_NuitTOTAL:93:=vl_HGGP_NuitTOTAL
			[HeberGement:5]HG_Reporté:94:=""
			[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
			
			// 06/09/2004
			[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
			// Fin Partie réservation
			
			[HeberGement:5]HG_FamGroupe:102:=va_HGGP_FamGroupe
			[HeberGement:5]HG_FamChef:103:=False:C215
			[HeberGement:5]HG_FamClé:104:=""
			[HeberGement:5]HG_FamCompo:105:=""
			[HeberGement:5]HG_FamNbPers:106:=0
			
			If (va_HGGP_FamClé>"")
				[HeberGement:5]HG_FamClé:104:=va_HGGP_FamClé
				[HeberGement:5]HG_FamNbPers:106:=1
				
				If ($6=1)
					[HeberGement:5]HG_FamChef:103:=True:C214
					[HeberGement:5]HG_FamCompo:105:=va_IDT_FCom
					[HeberGement:5]HG_FamNbPers:106:=vl_HGGP_FamNbP
					[HeberGement:5]HG_FamNbJour:107:=vl_HGGP_FamNbJ
					[HeberGement:5]HG_FamNbChambre:108:=vl_HGGP_FamNbC
					[HeberGement:5]HG_FamPrixJour:109:=vr_HGGP_FamPrixJ
					[HeberGement:5]HG_FamTotal:110:=vr_HGGP_FamPrixT
				End if 
				
			End if 
			
		Else 
			[HeberGement:5]HG_FamGroupe:102:=va_IDT_FGrp
			
			[HeberGement:5]HG_FamChef:103:=vb_IDT_FRes
			[HeberGement:5]HG_FamClé:104:=va_IDT_Ffam
			[HeberGement:5]HG_FamCompo:105:=va_IDT_FCom
			[HeberGement:5]HG_FamNbPers:106:=ve_IDT_FPer
		End if 
		
		[HeberGement:5]HG_FamCompo:105:=va_IDT_FCom
		[HeberGement:5]HG_FamCompoVar:117:=va_IDT_Fvar
		
		// 24/01/2005
		[HeberGement:5]HG_FamDistri1:112:=""  //va_IDT_FDi1
		[HeberGement:5]HG_FamDistri2:113:=""  //va_IDT_FDi2
		[HeberGement:5]HG_FamDistri3:114:=""  //va_IDT_FDi3
		[HeberGement:5]HG_FamDistri4:115:=""  //va_IDT_FDi4
		[HeberGement:5]HG_FamDistri5:116:=""  //va_IDT_FDi5
		
		// Fin 26/01/2004
		[HeberGement:5]HG_FamCasSpéc:111:=va_IDT_FCSp
		// 26/01/2004 puis annulé le 24/01/2005
		
		[HeberGement:5]HG_FamDistri1M:118:=0  //vr_IDT_FDi1
		[HeberGement:5]HG_FamDistri2M:119:=0  //vr_IDT_FDi2
		[HeberGement:5]HG_FamDistri3M:120:=0  //vr_IDT_FDi3
		[HeberGement:5]HG_FamDistri4M:121:=0  //vr_IDT_FDi4
		[HeberGement:5]HG_FamDistri5M:122:=0  //vr_IDT_FDi5
		// Fin 26/01/2004
		// Fin 24/01/2005
		
		[HeberGement:5]HG_GestionCentreNuit:133:=va_IDT_CtrJN
		
		$vb_OK:=($2=2)  // Report En mémoire
		
		If ($vb_OK)
			[HeberGement:5]HG_FamNbJour:107:=ve_IDT_FJou
			[HeberGement:5]HG_FamNbChambre:108:=ve_IDT_FChb
			[HeberGement:5]HG_FamPrixJour:109:=vr_IDT_FPxJ
			[HeberGement:5]HG_FamTotal:110:=vr_IDT_FPxT
			
			//27/09/2004      
			If (ve_IDT_ProlongTotN>0)
				[HeberGement:5]HG_FamGroupe:102:=va_IDT_ProlongGroupe
				
				If ([HeberGement:5]HG_FamChef:103)
					[HeberGement:5]HG_FamCompo:105:=va_IDT_ProlongCompo
					[HeberGement:5]HG_FamCompoVar:117:=va_IDT_ProlongCompoV
					[HeberGement:5]HG_FamNbPers:106:=ve_IDT_ProlongNbP
					[HeberGement:5]HG_FamNbJour:107:=ve_IDT_ProlongNbJ
					[HeberGement:5]HG_FamNbChambre:108:=ve_IDT_ProlongNbC
					[HeberGement:5]HG_FamPrixJour:109:=vr_IDT_ProlongPxJ
					[HeberGement:5]HG_FamTotal:110:=vr_IDT_ProlongPxT
				End if 
				
			End if 
			//fin 27/09/2004
			
			If ([HeberGement:5]HG_Nuit:2)
				P_ReportFlux("N"; $7)
			Else 
				P_ReportFlux("J"; $7)
			End if 
			
		End if 
		
		//FLAG du SIAO2/12/2011
		[HeberGement:5]HG_Flag_DAHO:156:=vb_IDT_Falg_Daho
		[HeberGement:5]HG_Flag_CapaciteAcces:158:=vb_IDT_Falg_Capacite
		[HeberGement:5]HG_Flag_FemViolence:157:=vb_IDT_Falg_Violence
		[HeberGement:5]HG_Flag_LogAutonome:159:=vb_IDT_Falg_Logement
		[HeberGement:5]HG_Flag_OrientCorrespondant:161:=vb_IDT_Falg_Orientation
		[HeberGement:5]HG_Flag_Souhait:160:=vb_IDT_Falg_Souhait
		[HeberGement:5]HG_Flag_RefusParStructure:162:=vb_IDT_Falg_RefusStrut
		[HeberGement:5]HG_Flag_RefusParDemandeur:163:=vb_IDT_Falg_RefusPers
		//fin FLAG du SIAO2/12/2011
		
		//Dossier SIA 13/12/2011
		[HeberGement:5]HG_DossierSIAO:164:=va_IDT_DossierSIAO
		
		//Type SIAO du  23/12/2011
		[HeberGement:5]HG_Type_Demande:165:=va_IDT_TypeDemande
		[HeberGement:5]HG_Type_Prescripteur:166:=va_IDT_TypePrescripteur
		[HeberGement:5]HG_Type_de_Place:167:=va_IDT_TypePlace
		
		$vb_OK:=(($2=3) | ($2=4))  // Report En mémoire Utilitaire
		
		If ($vb_OK)
			
			If ([HeberGement:5]HG_Nuit:2)
				P_ReportFluxA("N"; $7)
			Else 
				P_ReportFluxA("J"; $7)
			End if 
			
		End if 
		
	: ($1=5)  // INITIALISATIONS partie Saisie par groupe
		P_VariablesTransiteInit(5)
	: ($1=6)  // A cause des fiches 115
		[HeberGement:5]HG_Trans_DDASS:141:=False:C215
		[HeberGement:5]HG_Trans_RéférenceID:142:=0
		[HeberGement:5]HG_Trans_FicheNuméro:143:=""
		[HeberGement:5]HG_Trans_HB_ID:144:=0
		[HeberGement:5]HG_Trans_LC_ID:145:=0
		[HeberGement:5]HG_Trans_CentreNom:146:=""
		[HeberGement:5]HG_Trans_FamClé:147:=""
		[HeberGement:5]HG_Trans_Plateforme:148:=""
	Else 
		ASSERT:C1129(False:C215; "Mauvais sélecteur")  // #20180530-3
End case 