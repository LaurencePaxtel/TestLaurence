//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : Go_HébergementReportAUTO
//{
//{          Lundi 19 janvier 2003 à 11:47
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

READ ONLY:C145(*)
MESSAGES OFF:C175

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215

ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
C_BOOLEAN:C305($vb_OK)
vb_OK:=F_Report_FullDuplexVAR  //••   `Variables communes au report


C_TEXT:C284(va_TransFrom)

vb_Serveur:=$1
If (vb_Serveur)
	$vb_OK:=F_Report_ServeurVAR  //••   `Variables communes au report
	//Variables communes au report constantes
	DebutDecVarReport
	//Report automatiques  
	//Variable paramètres du report auto
	//DebutDecVarParamRepAuto 
	//DebutDecVarParamRepAuto2 
	DebutDécParamServeur
	
End if 

C_BOOLEAN:C305(vb_OK; vb_Report)
C_LONGINT:C283(gError; vl_ii; vl_ij)
vb_OK:=False:C215
vb_Report:=False:C215
gError:=0



//Variables propres au report
C_LONGINT:C283(vl_NoRéfHG; vl_NoFicheHG; vl_NoRéfHGNb)


//Variables compteur du report
C_LONGINT:C283(<>vl_RepOK)
C_LONGINT:C283(<>vl_RepR)  //Reporté (◊va_RepR:="R")
C_LONGINT:C283(<>vl_RepRE)  //Reporté mais excusé et non clôturé (◊va_RepRE:="RE")
C_LONGINT:C283(<>vl_RepRP)  //Reporté par prolongation la première fois (◊va_RepRP:="RP")
C_LONGINT:C283(<>vl_RepF)  //Fin (◊va_RepF:="F")
C_LONGINT:C283(<>vl_RepA)  //Absence (◊va_RepA:="A")
C_LONGINT:C283(<>vl_RepO)  //O Réorienté (◊va_RepO:="O")
C_LONGINT:C283(<>vl_RepE)  //Report effectué  (◊va_RepE:="")

<>vl_RepOK:=0
<>vl_RepR:=0
<>vl_RepRE:=0
<>vl_RepRP:=0
<>vl_RepF:=0
<>vl_RepA:=0
<>vl_RepO:=0
<>vl_RepE:=0


//Variables hébergement

C_LONGINT:C283(ve_IDT_ProlongTotN)
ve_IDT_ProlongTotN:=0
C_TEXT:C284(va_IDT_ProlongGroupe)
va_IDT_ProlongGroupe:=""
C_LONGINT:C283(vl_IDT_ProlongLC)
vl_IDT_ProlongLC:=0
C_TEXT:C284(va_IDT_ProlongCompo)
C_TEXT:C284(va_IDT_ProlongCompoV)
C_LONGINT:C283(ve_IDT_ProlongNbP)
C_LONGINT:C283(ve_IDT_ProlongNbJ)
C_LONGINT:C283(ve_IDT_ProlongNbC)
C_REAL:C285(vr_IDT_ProlongPxJ)
C_REAL:C285(vr_IDT_ProlongPxT)


If (F_VariablesTransite(0; 3; False:C215))
End if 

C_LONGINT:C283(vL_NbFiches)
C_LONGINT:C283(vl_CHJx)
C_LONGINT:C283(vl_CHNx)
C_LONGINT:C283(vl_RéfU_HBB)

C_LONGINT:C283(vl_IDT_IDHB)
C_LONGINT:C283(vl_IDT_IDHG)

C_BOOLEAN:C305(vb_IDT_NUIT)

C_TEXT:C284(va_Rép)
C_TEXT:C284(va_Rép2)

C_TEXT:C284(va_Réservation)




DébutInitReportAuto(4; $2)


If (vb_ReportAuto)
	
	Repeat 
		
		//Analyse des dates et heures
		If (vb_Serveur)
			vd_DateServeur:=Current date:C33(*)
			vd_HeureServeur:=Current time:C178(*)
			vd_DateRéelle:=vd_DateServeur
			vd_HeureRéelle:=vd_HeureServeur+(8*3600)
			If (vd_HeureRéelle>?23:59:59?)
				vd_DateRéelle:=vd_DateRéelle+1
				vd_HeureRéelle:=vd_HeureRéelle-(24*3600)
			End if 
		Else 
			vd_DateRéelle:=Current date:C33
			vd_HeureRéelle:=Current time:C178
			vd_DateServeur:=vd_DateRéelle
			vd_HeureServeur:=vd_HeureRéelle-(8*3600)
			If (vd_HeureServeur<?00:00:00?)
				vd_DateServeur:=vd_DateServeur-1
				vd_HeureServeur:=(24*3600)+vd_HeureServeur
			End if 
		End if 
		
		
		If (vd_HeureRéelle>=vh_ReportAuto1) & (vd_HeureRéelle<=vh_ReportAuto2)
			vb_Report:=True:C214
		Else 
			vb_Report:=False:C215
		End if 
		If (vb_Report)
			//Analyse des jours de report
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
		
		If (vb_Report)
			vb_Report:=False:C215
			//On cherche si le report a déjà été fait
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_DateRéelle; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
			//4/11/2008
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=vl_T_CentreCodeDebut; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=vl_T_CentreCodeFin; *)
			//Fin 4/11/2008
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92>1)
			MultiSoc_Filter(->[HeberGement:5])
			vL_NbFiches:=Records in selection:C76([HeberGement:5])
			If (vL_NbFiches>0)
				//Réponse le report a déjà été fait
			Else 
				vb_Report:=True:C214
			End if 
			
			If (vb_Report)
				//Le report n'a pas encore été fait
				//Y a t il des fiches à reporter
				vb_Report:=False:C215
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=(vd_DateRéelle-1); *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
				//4/11/2008
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=vl_T_CentreCodeDebut; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=vl_T_CentreCodeFin; *)
				//Fin 4/11/2008
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0)
				MultiSoc_Filter(->[HeberGement:5])
				vL_NbFiches:=Records in selection:C76([HeberGement:5])
				If (vL_NbFiches>0)
					//Oui il y a des fiches à reporter
					vb_Report:=True:C214
					ARRAY LONGINT:C221(t_HGrepID; 0)
					SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; t_HGrepID)
				End if 
			End if 
			
			If (vb_Report)
				//On fait le report  gError:=0
				ON ERR CALL:C155("i_Error")
				vL_NbFiches:=0
				
				
				ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
				ARRAY LONGINT:C221(tl_RATTRAPE_Réf_HG; 0)
				
				//Vérification et création des lits
				vl_CHJx:=0
				vl_CHNx:=0
				va_DateType:=Uut_NumeroteLitsType(vd_DateRéelle; "J")
				QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
				
				QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=va_DateType; *)
				QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=va_DateType)
				
				MultiSoc_Filter(->[CentresLits:16])
				
				vl_CHJx:=Records in selection:C76([CentresLits:16])
				va_DateType:=Uut_NumeroteLitsType(vd_DateRéelle; "N")
				QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
				MultiSoc_Filter(->[CentresLits:16])
				vl_CHNx:=Records in selection:C76([CentresLits:16])
				If (vl_CHNx<=0) | (vl_CHNx<=0)
					P_DisponibilitéNew(vd_DateRéelle; 0; 0)
				End if 
				
				//Création des reports
				vl_NoRéfHG:=Uut_Numerote(->[HeberGement:5])
				vl_NoFicheHG:=Uut_Numerote115(vd_DateRéelle)
				vl_NoRéfHGNb:=0
				
				For ($ii; 1; Size of array:C274(t_HGrepID))
					
					
					//========================================
					// Modified by: Kevin HASSAL (20/02/2020)
					//========================================
					// Analyse des jours de report selon les préferences de l'hébergé
					//========================================
					
					//If (HG_Get_Reports_Config )
					
					//Case of 
					//: (vl_ii=1) & (chk_lundi)
					//: (vl_ii=2) & (chk_mardi)
					//: (vl_ii=3) & (chk_mercredi)
					//: (vl_ii=4) & (chk_jeudi)
					//: (vl_ii=5) & (chk_vendredi)
					//: (vl_ii=6) & (chk_samedi)
					//: (vl_ii=7) & (chk_dimanche)
					//Else 
					//vb_Report:=False
					//End case 
					
					//End if 
					
					If (vb_Report)
						
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=t_HGrepID{$ii})
						MultiSoc_Filter(->[HeberGement:5])
						If (Records in selection:C76([HeberGement:5])=1)
							Va_NoUFicR:=[HeberGement:5]HG_FicheNuméro:3
							If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_Reporté:94="")
								If ([HeberGement:5]HG_NuitReste:95<=0) | ([HeberGement:5]HG_Cloturée:67=False:C215)
									READ WRITE:C146([HeberGement:5])
									QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=Va_NoUFicR)
									MultiSoc_Filter(->[HeberGement:5])
									If (Records in selection:C76([HeberGement:5])=1)
										Repeat 
											LOAD RECORD:C52([HeberGement:5])
										Until (Not:C34(Locked:C147([HeberGement:5])))
										[HeberGement:5]HG_Reporté:94:=va_RepF
										vl_RepF:=vl_RepF+1
										[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
										
										SAVE RECORD:C53([HeberGement:5])
										UNLOAD RECORD:C212([HeberGement:5])
									End if 
									UNLOAD RECORD:C212([HeberGement:5])
									READ ONLY:C145([HeberGement:5])
								Else 
									vl_NoRéfHG:=vl_NoRéfHG+1
									vl_NoFicheHG:=vl_NoFicheHG+1
									vl_NoRéfHGNb:=vl_NoRéfHGNb+1
									//P_ReportPasse1
									If (F_VariablesTransite(2; 3; False:C215))
									End if 
									READ WRITE:C146([HeberGement:5])
									CREATE RECORD:C68([HeberGement:5])
									MultiSoc_Init_Structure(->[HeberGement:5])
									[HeberGement:5]HG_DateCreationFiche:149:=Current date:C33(*)
									
									//P_ReportPasse2a (vd_DateRéelle;vl_NoRéfHG;vl_NoFicheHG;0)
									If (F_VariablesTransite(4; 3; False:C215; vd_DateRéelle; vl_NoRéfHG; vl_NoFicheHG; 0))
									End if 
									
									
									//Le 6/5/2009
									[HeberGement:5]HG_Signalement:12:="*Report"
									
									vl_RepOK:=vl_RepOK+1
									
									//ici reunir les fiches reportées
									vl_Trans_Réf_HG:=Size of array:C274(tl_Trans_Réf_HG)+1
									INSERT IN ARRAY:C227(tl_Trans_Réf_HG; vl_Trans_Réf_HG)
									tl_Trans_Réf_HG{vl_Trans_Réf_HG}:=[HeberGement:5]HG_ReferenceID:1
									//FIN ici reunir les fiches reportées
									
									[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
									
									
									SAVE RECORD:C53([HeberGement:5])
									UNLOAD RECORD:C212([HeberGement:5])
									READ ONLY:C145([HeberGement:5])
									
									P_ReportPasse3a(1)
								End if 
							End if 
						End if 
						
					End if 
					
					
				End for 
				
				vl_NoRéfHG:=Uut_NumerotePlus(->[HeberGement:5]; vl_NoRéfHGNb)
				var $vaCPT_115 : Text
				$vaCPT_115:=Storage:C1525.numerotation.vaCPT_115
				vl_NoFicheHG:=Uut_NumerotePlus(->$vaCPT_115; vl_NoRéfHGNb)
				ARRAY LONGINT:C221(t_HGrepID; 0)
				
				//Message sur le déroulement du Report strictement
				$vb_OK:=F_Report_FullDuplexMessage(vb_Serveur; "OK"; "Report Auto "+("sur serveur "*Num:C11(vb_Serveur))+("sur poste "*Num:C11(vb_Serveur=False:C215))+"effectué"; "Fiches reportées : "+String:C10(Size of array:C274(tl_Trans_Réf_HG)))
				//RAJOUTER ICI SUIVANT LES OPTIONS, L'EXPORT DES FICHES REPORTEES
				//ici pour les Bases CHRS exporter les reports
				//Les CHRS envoyent chaque jour leurs reports quotidients au 115
				//Dans un  répertoire intitulé 115 Reports
				//Quand il seront lu ils seront mis dans un répertoire dit 115 Report LU
				//•Est ce une base CHRS  et y a til des fiches reportées
				$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; vb_Serveur; "Report Auto "+("sur serveur "*Num:C11(vb_Serveur))+("sur poste "*Num:C11(vb_Serveur=False:C215))+" Transfert")
				
				
				
				
				
				vb_Report:=False:C215
			End if 
			
		Else 
			//C'est pas le bon Jour      
		End if 
		
		vb_OK:=(vb_ReportAuto=False:C215)
		If (vb_ReportAuto) & (vb_Report=False:C215)
			If (vb_Serveur)
				DELAY PROCESS:C323(Current process:C322; vl_ReportAutoTicks)
			Else 
				DELAY PROCESS:C323(PR_ReportServeur; vl_ReportAutoTicks)
			End if 
			If (vb_ReportAuto)
				DébutInitReportAuto(4; $2)
			Else 
				vb_OK:=False:C215
			End if 
		End if 
	Until (vb_OK)
End if 



ON ERR CALL:C155("")

If (vb_Serveur)
	PR_ReportServeur:=0
Else 
	PR_ReportLocal:=0
End if 