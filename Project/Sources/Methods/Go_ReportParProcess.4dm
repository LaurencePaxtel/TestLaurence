//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : Go_ReportParProcess
//{
//{          Lundi 23 février 2009 à 12:25
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)
var $2 : Text  // ref_structure

Use (Storage:C1525.societeDetail)
	Storage:C1525.societeDetail.Ref_Structure:=$2
End use 
ref_soc_active:=$2


var vl_T_CentreCodeDebut : Integer
var vl_T_CentreCodeFin : Integer

$codeCentre_i:=ds:C1482.SOciete.query("Ref_Structure = :1"; $2).first().SO_CodeCentre
P_CodeCentre(->vl_T_CentreCodeDebut; ->vl_T_CentreCodeFin; $codeCentre_i)

C_TEXT:C284($vt_Temp)
C_LONGINT:C283($ii)
C_BOOLEAN:C305($vb_OK; $B_Dummy)

C_TEXT:C284(Va_NoUFicR; va_Rép; va_Rép2; va_Réservation; va_TransFrom)
C_LONGINT:C283(gError; vl_ii; vl_ij; vL_NbFiches; vL_NbSortants; vl_CHJx; vl_CHNx; vl_RéfU_HG; vl_RéfU_HBB; vl_IDT_IDHB; vl_IDT_IDHG; vl_NoRéfHG; vl_NoFicheHG; vl_NoRéfHGNb; vl_NbFichesReport)
C_BOOLEAN:C305(vb_SurServeur; vb_OK; vb_Report; vb_IDT_NUIT)
C_TIME:C306(vh_Clic1)

vb_SurServeur:=$1
MultiSoc_Init_On_Server(Count parameters:C259; $2)

READ ONLY:C145(*)
MESSAGES OFF:C175

gError:=0
vL_NbFiches:=0
vl_RéfU_HG:=0
vl_NbFichesReport:=0

vb_OK:=False:C215
vb_Report:=False:C215

vh_Clic1:=?00:00:00?

$vb_OK:=F_Report_FullDuplexVAR  //••   `Variables communes au report
$vb_OK:=F_VariablesTransite(0; 2; False:C215)

vl_RepOK:=0
vl_RepR:=0
vl_RepRE:=0
vl_RepRP:=0
vl_RepF:=0
vl_RepA:=0
vl_RepO:=0
vl_RepE:=0

DébutInitReportAuto(4; $2)

If (vb_ReportAuto)
	
	Repeat 
		
		// Modified by: Kevin HASSAL (10-01-2019)
		// Multi-sociétés : Pour initialier a chaque passage
		DebutDécVar
		DébutInitReportAuto(4; $2)
		
		// Analyse des dates et heures
		// •(1) Les dates et heures    
		i_DateServeurPoste(False:C215)  //i_DateServeurPoste (vb_SurServeur) : pour éviter le problème des dates
		If (vd_HeureRéelle>=vh_ReportAuto1) & (vd_HeureRéelle<=vh_ReportAuto2)
			vb_Report:=True:C214
		Else 
			vb_Report:=False:C215
		End if 
		
		If (vb_Report)
			
			// Analyse des jours de report
			vl_ii:=Day number:C114(vd_DateRéelle)
			vb_Report:=True:C214
			
			Case of 
				: (vl_ii=ve_ReportAutoDi)
				: (vl_ii=ve_ReportAutoLu)
				: (vl_ii=ve_ReportAutoMa)
				: (vl_ii=ve_ReportAutoMe)
				: (vl_ii=ve_ReportAutoJe)
				: (vl_ii=ve_ReportAutoVe)
				: (vl_ii=ve_ReportAutoSa)
				Else 
					vb_Report:=False:C215
			End case 
			
		End if 
		
		If (vb_Report)  // Les paramètres du report sont OK, y a t-il des fiches à reporter ?
			vb_Report:=False:C215
			
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_DateRéelle; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92>1; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=vl_T_CentreCodeDebut; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=vl_T_CentreCodeFin; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]Ref_Structure:169=ref_soc_active)
			
			
			If (Records in selection:C76([HeberGement:5])=0)  // Le report n'a pas déja été fait pour ce jour 
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=(vd_DateRéelle-1); *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=vl_T_CentreCodeDebut; *)  //4/11/2008
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=vl_T_CentreCodeFin; *)  //Fin 4/11/2008
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]Ref_Structure:169=ref_soc_active)
				
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_CentreNom:62; >)
				vL_NbFiches:=Records in selection:C76([HeberGement:5])
				
				If (vL_NbFiches>0)  // Oui il y a des fiches à reporter
					vb_Report:=True:C214
					
					ARRAY LONGINT:C221(t_HGrepID; 0)
					SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; t_HGrepID)
				End if 
				
			End if 
			
		End if 
		
		If (vb_Report)  // On fait le report  gError:=0
			Use (Storage:C1525.societeDetail)
				Storage:C1525.societeDetail.Ref_Structure:=$2
			End use 
			
			ON ERR CALL:C155("i_Error")
			vL_NbFiches:=0
			
			// Etat du centre Fermé ou ouvert
			QUERY:C277([LesCentres:9]; [LesCentres:9]Ref_Structure:61=ref_soc_active)
			
			READ WRITE:C146([LesCentres:9])
			APPLY TO SELECTION:C70([LesCentres:9]; P_CentreEtat)
			
			READ ONLY:C145([LesCentres:9])
			
			ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
			ARRAY LONGINT:C221(tl_RATTRAPE_Réf_HG; 0)
			
			$vb_OK:=F_Regional_RefsTableau(0)
			
			// Vérification et création des lits
			vl_CHJx:=0
			vl_CHNx:=0
			
			va_DateType:=Uut_NumeroteLitsType(vd_DateRéelle; "J")
			
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
			QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=vl_T_CentreCodeDebut; *)  // #20170629-1 
			QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=vl_T_CentreCodeFin; *)  // #20170629-1
			QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]Ref_Structure:31=ref_soc_active)
			
			
			vl_CHJx:=Records in selection:C76([CentresLits:16])
			
			va_DateType:=Uut_NumeroteLitsType(vd_DateRéelle; "N")
			
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
			QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=vl_T_CentreCodeDebut; *)  // #20170629-1
			QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=vl_T_CentreCodeFin; *)  // #20170629-1
			QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]Ref_Structure:31=ref_soc_active)
			
			vl_CHNx:=Records in selection:C76([CentresLits:16])
			
			If (vl_CHNx<=0) | (vl_CHJx<=0)
				P_DisponibilitéNew(vd_DateRéelle; 0; 0)
			End if 
			
			// Création des reports
			vl_NoRéfHG:=Uut_Numerote(->[HeberGement:5])
			vl_NoFicheHG:=Uut_Numerote115(vd_DateRéelle)
			vl_NoRéfHGNb:=0
			
			READ WRITE:C146([HeberGement:5])
			
			For ($ii; 1; Size of array:C274(t_HGrepID))
				$vb_OK:=False:C215
				
				ve_IDT_ProlongTotN:=0
				vl_IDT_ProlongLC:=0
				ve_IDT_ProlongNbP:=0
				ve_IDT_ProlongNbJ:=0
				ve_IDT_ProlongNbC:=0
				vr_IDT_ProlongPxJ:=0
				vr_IDT_ProlongPxT:=0
				
				va_IDT_ProlongCompo:=""
				va_IDT_ProlongCompoV:=""
				va_IDT_ProlongGroupe:=""
				
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=t_HGrepID{$ii}; *)
				QUERY:C277([HeberGement:5]; [HeberGement:5]Ref_Structure:169=ref_soc_active)
				
				If (Records in selection:C76([HeberGement:5])=1)
					
					//========================================
					// Modified by: Kevin HASSAL (20/02/2020)
					//========================================
					// Analyse des jours de report selon les préferences de l'hébergé
					//========================================
					If (HG_Get_Reports_Config)
						
						Case of 
							: (vl_ii=1) & (chk_dimanche)
							: (vl_ii=2) & (chk_lundi)
							: (vl_ii=3) & (chk_mardi)
							: (vl_ii=4) & (chk_mercredi)
							: (vl_ii=5) & (chk_jeudi)
							: (vl_ii=6) & (chk_vendredi)
							: (vl_ii=7) & (chk_samedi)
							Else 
								vb_Report:=False:C215
						End case 
						
					End if 
					
					If (vb_Report)
						Va_NoUFicR:=[HeberGement:5]HG_FicheNuméro:3
						
						If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_Reporté:94="")
							
							If ([HeberGement:5]HG_NuitReste:95<=0)  //| ([HeberGement]HG_Cloturée=Faux)
								
								// Est-ce que cette personne qui appartient à un groupe a une prolongation ?
								QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=[HeberGement:5]HG_HB_ID:19; *)
								QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]Ref_Structure:11=ref_soc_active)
								
								If (Records in selection:C76([GroupeHeberges:37])=1)
									QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GroupeHeberges:37]GH_GP_Référence:2; *)
									QUERY:C277([Prolongation:38]; [Prolongation:38]Ref_Structure:26=ref_soc_active)
									
									If (Records in selection:C76([Prolongation:38])>0)
										QUERY SELECTION:C341([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6=[DiaLogues:3]DL_Date:2)
										
										If (Records in selection:C76([Prolongation:38])=1)
											ve_IDT_ProlongTotN:=[Prolongation:38]PR_RésaNbJours:8
											va_IDT_ProlongGroupe:=[Prolongation:38]PR_RésaGroupe:14
											vl_IDT_ProlongLC:=[Prolongation:38]PR_LC_ID:9
											
											va_IDT_ProlongCompo:=[Prolongation:38]PR_FamilleComposition:15
											va_IDT_ProlongCompoV:=[Prolongation:38]PR_FamilleCompositionV:16
											ve_IDT_ProlongNbP:=[Prolongation:38]PR_NbPersonnes:17
											ve_IDT_ProlongNbJ:=[Prolongation:38]PR_NbJours:18
											ve_IDT_ProlongNbC:=[Prolongation:38]PR_NbChambres:19
											vr_IDT_ProlongPxJ:=[Prolongation:38]PR_PrixJour:20
											vr_IDT_ProlongPxT:=[Prolongation:38]PR_PrixTotal:21
											
											Tab_PR_data(2; 0)
											Tab_PR_data(3; 0)
											
											$vb_OK:=True:C214
										End if 
										
									End if 
									
								End if 
								
							Else   // Ici report traditionnel
								$vb_OK:=True:C214
							End if 
							
							If ($vb_OK)
								vl_NoRéfHG:=vl_NoRéfHG+1
								vl_NoFicheHG:=vl_NoFicheHG+1
								vl_NoRéfHGNb:=vl_NoRéfHGNb+1
								
								// Ici on recopie les champs de l'hebergement dans des variables
								P_ReportPasse1
								
								If (vb_IDT_TransDDASS)  // •Est ce une base CHRS  et y a til des fiches reportées :  ici reunir les fiches 
									$vb_OK:=True:C214
									
									If (<>vb_T_Fiches115)
										$vb_OK:=(va_IDT_TransFiche="")  //25/5/2011 (c'est pas une fiche 115)
									End if 
									
									If ($vb_OK)
										F_Report_FullReporté(->tl_Trans_Réf_HG; vl_NoRéfHG)
									End if 
									
									$B_Dummy:=F_Regional_Refs(->tl_Regional_Réf_HG; vl_NoRéfHG)
								End if 
								//FIN ici reunir les fiches reportées
								
								// On duplique l'hebergement, et les variables sont vidées dans les champs : à réécrire car stupide !!!!
								P_ReportPasse2(vd_DateRéelle; vl_NoRéfHG; vl_NoFicheHG; 1)
								vl_NbFichesReport:=vl_NbFichesReport+1
								
								// Ici on revient sur l'hebergement avant de dupliquer, on tague R pour reporter
								P_ReportPasse3(1)
							End if 
							
							If (False:C215)
								vl_NoRéfHG:=vl_NoRéfHG+1
								vl_NoFicheHG:=vl_NoFicheHG+1
								vl_NoRéfHGNb:=vl_NoRéfHGNb+1
								
								F_VariablesTransite(2; 3; False:C215)
								
								CREATE RECORD:C68([HeberGement:5])
								MultiSoc_Init_Structure(->[HeberGement:5])
								[HeberGement:5]HG_DateCreationFiche:149:=Current date:C33(*)
								
								F_VariablesTransite(4; 3; False:C215; vd_DateRéelle; vl_NoRéfHG; vl_NoFicheHG; 0)
								
								// Le 6/5/2009
								[HeberGement:5]HG_Signalement:12:="*Report"
								
								vl_RepOK:=vl_RepOK+1
								
								If (vb_IDT_TransDDASS)  // Ici reunir les fiches reportées DAS à exporter
									vl_Trans_Réf_HG:=Size of array:C274(tl_Trans_Réf_HG)+1
									INSERT IN ARRAY:C227(tl_Trans_Réf_HG; vl_Trans_Réf_HG)
									
									tl_Trans_Réf_HG{vl_Trans_Réf_HG}:=[HeberGement:5]HG_ReferenceID:1
									$vb_OK:=F_Regional_Refs(->tl_Regional_Réf_HG; [HeberGement:5]HG_ReferenceID:1)
								End if 
								
								[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
								
								SAVE RECORD:C53([HeberGement:5])
								UNLOAD RECORD:C212([HeberGement:5])
								
								P_ReportPasse3a(1)
							End if 
							
						End if 
						
					End if 
					
				End if 
				
			End for 
			
			READ ONLY:C145([HeberGement:5])
			
			vl_NoRéfHG:=Uut_NumerotePlus(->[HeberGement:5]; vl_NoRéfHGNb)
			var $vaCPT_115 : Text
			$vaCPT_115:=Storage:C1525.numerotation.vaCPT_115
			vl_NoFicheHG:=Uut_NumerotePlus(->$vaCPT_115; vl_NoRéfHGNb)
			ARRAY LONGINT:C221(t_HGrepID; 0)
			
			//Message sur le déroulement du Report strictement
			$vt_Temp:="Fiches reportées : "+String:C10(Size of array:C274(tl_Trans_Réf_HG))
			
			//SÉLECTION DES FICHES DE FIN D'HÉBERGEMENT 3/5/2010
			P_HébergementSortant(4)
			
			If (vb_M_MailOui)
				$vb_OK:=F_MailReport_Corps(1)
				$vt_Temp:=$vt_Temp+Char:C90(Retour à la ligne:K15:40)+Char:C90(Retour à la ligne:K15:40)
				$vt_Temp:=$vt_Temp+"Liste des personnes en fin d'hébergement : "+String:C10(vL_NbSortants)
			End if 
			
			// Ici on envoie un message dans la messagerie
			$vb_OK:=F_Report_FullDuplexMessage(vb_SurServeur; "OK"; "Report Auto "+("sur serveur "*Num:C11(vb_SurServeur))+("sur poste "*Num:C11(vb_SurServeur=False:C215))+"effectué"; $vt_Temp)
			
			//RAJOUTER ICI SUIVANT LES OPTIONS, L'EXPORT DES FICHES REPORTEES
			//ici pour les Bases CHRS exporter les reports
			//Les CHRS envoyent chaque jour leurs reports quotidients au 115
			//Dans un  répertoire intitulé 115 Reports
			//Quand il seront lu ils seront mis dans un répertoire dit 115 Report LU
			//•Est ce une base CHRS  et y a t-il des fiches reportées ?
			$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; vb_SurServeur; "Report Auto "+("sur serveur "*Num:C11(vb_SurServeur))+("sur poste "*Num:C11(vb_SurServeur=False:C215))+" Transfert")
			
			If (ve_ConsoRegion_Mode=1)  //28/1/2011 : Export pour le régional
				$vb_OK:=F_Report_FullDuplexMessage(vb_SurServeur; "OK"; "Transfert régional Auto "+("sur serveur "*Num:C11(vb_SurServeur))+("sur poste "*Num:C11(vb_SurServeur=False:C215))+"effectué"; $vt_Temp)
				$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; vb_SurServeur; "Transfert régional "+("sur serveur "*Num:C11(vb_SurServeur))+("sur poste "*Num:C11(vb_SurServeur=False:C215))+" Report")
			End if 
			
			//••• Nouveau le 26/10/2010
			//•••  Mail des centres consolidés
			If (vb_T_ModeCHRS=False:C215)
				Go_OccupationWeek(1; vd_DateRéelle)
			End if 
			
			If (vb_SurServeur=False:C215)
				
				If (PR_Sortants=0)
					Process_Go(->PR_Sortants; "Go_HébergementSortants"; "Sortants"; 64)
					
					Repeat 
						IDLE:C311
					Until (PR_Sortants>0)
					
				End if 
				
				POST OUTSIDE CALL:C329(PR_Sortants)
			End if 
			
			vb_Report:=False:C215
		End if 
		
		vb_OK:=(vb_ReportAuto=False:C215)
		
		If (vb_ReportAuto)
			
			DELAY PROCESS:C323(Current process:C322; vl_ReportAutoTicks)
			
			DébutInitReportAuto(4; $2)
			DebutParamMail(1; 0)
			
			vb_OK:=(vb_ReportAuto=False:C215)
		End if 
		
	Until (vb_OK)
	
End if 

ON ERR CALL:C155("")

If (vb_SurServeur)
	PR_ReportServeur:=0
Else 
	PR_ReportLocal:=0
End if 