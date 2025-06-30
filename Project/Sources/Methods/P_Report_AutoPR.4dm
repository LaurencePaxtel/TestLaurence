//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Report_AutoPR
//{
//{          Lundi 13 septembre 2004 à 17:24:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_NbFiches; vL_NbSortants; vl_NbFichesReport)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($va_ii)
F_Report_FullDuplexTableau
$vb_OK:=F_Regional_RefsTableau(0)
vl_NbFichesReport:=0

If (Records in selection:C76([HeberGement:5])>0)
	
	i_Message("Recherche en cours…")
	
	Tab_PR_data(0; 0)
	
	vd_DateServeur:=!00-00-00!
	vl_CHJx:=0
	vl_CHNx:=0
	
	
	va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "J")
	vd_DateServeur:=[DiaLogues:3]DL_Date:2
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
	MultiSoc_Filter(->[CentresLits:16])
	//4/11/2008
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)
	QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin)
	//Fin 4/11/2008
	vl_CHJx:=Records in selection:C76([CentresLits:16])
	
	
	va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "N")
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
	MultiSoc_Filter(->[CentresLits:16])
	//4/11/2008
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)
	QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin)
	//Fin 4/11/2008
	vl_CHNx:=Records in selection:C76([CentresLits:16])
	
	
	CLOSE WINDOW:C154
	If (vl_CHNx<=0) | (vl_CHJx<=0)
		ALERT:C41("Vous devez saisir les disponibilités.")
	Else 
		ARRAY LONGINT:C221(t_HGrepID; 0)
		If (i_Confirmer("Confirmez-vous le report automatique ?"))
			
			i_Message("Report automatique en cours…")
			
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; t_HGrepID)
			
			//Annulation de cette méthode le 12 avril 2005
			//vl_NoRéfHG:=Uut_Numerote (->[HéberGement])
			//vl_NoFicheHG:=Uut_Numerote115 (vd_DateServeur)
			
			//Nouvelle méthode le 12 avril 2005
			$vl_NbFiches:=Size of array:C274(t_HGrepID)+1
			vl_NoRéfHG:=Uut_NumerotePlus(->[HeberGement:5]; $vl_NbFiches)
			
			vl_NoFicheHG:=Uut_Numerote115Plus(vd_DateServeur; $vl_NbFiches)
			
			vl_NoRéfHGNb:=0
			$va_ii:=String:C10(Size of array:C274(t_HGrepID))
			For ($ii; 1; Size of array:C274(t_HGrepID))
				i_MessageSeul("Report automatique en cours : "+$va_ii+"/"+String:C10($ii))
				
				$vb_OK:=False:C215
				ve_IDT_ProlongTotN:=0
				va_IDT_ProlongGroupe:=""
				vl_IDT_ProlongLC:=0
				
				va_IDT_ProlongCompo:=""
				va_IDT_ProlongCompoV:=""
				ve_IDT_ProlongNbP:=0
				ve_IDT_ProlongNbJ:=0
				ve_IDT_ProlongNbC:=0
				vr_IDT_ProlongPxJ:=0
				vr_IDT_ProlongPxT:=0
				
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=t_HGrepID{$ii})
				MultiSoc_Filter(->[HeberGement:5])
				If (Records in selection:C76([HeberGement:5])=1)
					
					Va_NoUFicR:=[HeberGement:5]HG_FicheNuméro:3
					
					If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_Reporté:94="")
						If ([HeberGement:5]HG_NuitReste:95<=0)
							
							//Est ce que cette personne qui appartient à un groupe a une prolongation
							QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=[HeberGement:5]HG_HB_ID:19)
							MultiSoc_Filter(->[GroupeHeberges:37])
							If (Records in selection:C76([GroupeHeberges:37])=1)
								QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GroupeHeberges:37]GH_GP_Référence:2)
								MultiSoc_Filter(->[Prolongation:38])
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
							
							//Ici ancienne manière  n'est plas actif evacué par la sélection initiale
							If ($vb_OK=False:C215)
								READ WRITE:C146([HeberGement:5])
								QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=Va_NoUFicR)
								MultiSoc_Filter(->[HeberGement:5])
								If (Records in selection:C76([HeberGement:5])=1)
									If (i_NonVerrou(->[HeberGement:5]))
										[HeberGement:5]HG_Reporté:94:=<>va_RepF
										[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
										
										SAVE RECORD:C53([HeberGement:5])
										UNLOAD RECORD:C212([HeberGement:5])
									Else 
										UNLOAD RECORD:C212([HeberGement:5])
									End if 
								End if 
								READ ONLY:C145([HeberGement:5])
							End if 
							
							
						Else   //  Si ([HéberGement]HG_NuitReste<=0)
							//Ici report traditionnel              
							$vb_OK:=True:C214
						End if   //  Si ([HéberGement]HG_NuitReste<=0)
						
						
						If ($vb_OK)
							vl_NoRéfHG:=vl_NoRéfHG+1
							vl_NoFicheHG:=vl_NoFicheHG+1
							vl_NoRéfHGNb:=vl_NoRéfHGNb+1
							P_ReportPasse1
							
							//•Est ce une base CHRS  et y a til des fiches reportées :  ici reunir les fiches 
							If (vb_IDT_TransDDASS)
								$vb_OK:=True:C214
								If (<>vb_T_Fiches115)
									$vb_OK:=(va_IDT_TransFiche="")  //25/5/2011 (c'est pas une fiche 115)
								End if 
								
								If ($vb_OK)
									F_Report_FullReporté(->tl_Trans_Réf_HG; vl_NoRéfHG)
								End if 
								If (F_Regional_Refs(->tl_Regional_Réf_HG; vl_NoRéfHG))
								End if 
							End if 
							//FIN ici reunir les fiches reportées
							
							P_ReportPasse2([DiaLogues:3]DL_Date:2; vl_NoRéfHG; vl_NoFicheHG; 1)
							vl_NbFichesReport:=vl_NbFichesReport+1
							
							P_ReportPasse3(1)
						End if 
						
					End if   //   Si ([HéberGement]HG_Réservation) & ([HéberGement]HG_Reporté="")
					
				End if 
			End for 
			
			//Annulation de cette méthode le 12 avril 2005
			// vl_NoRéfHG:=Uut_NumerotePlus (->[HéberGement];vl_NoRéfHGNb)
			//vl_NoFicheHG:=Uut_NumerotePlus (->◊vaCPT_115;vl_NoRéfHGNb)
			
			CLOSE WINDOW:C154
			
			//Mise à jour des prolongations
			P_ReportPasse4MàJPro([DiaLogues:3]DL_Date:2; 1)
			Tab_PR_data(0; 0)
			
			
			//Message sur le déroulement du Report strictement
			$vt_Temp:="Fiches reportées : "+String:C10(vl_NbFichesReport)
			//SÉLECTION DES FICHES DE FIN D'HÉBERGEMENT 3/5/2010
			P_HébergementSortant(5)
			If (<>vb_M_MailOui)
				$vb_OK:=F_MailReport_Corps(3)
				$vt_Temp:=$vt_Temp+Char:C90(13)+Char:C90(13)
				$vt_Temp:=$vt_Temp+"Liste des personnes en fin d'hébergement : "+String:C10(vL_NbSortants)
			End if 
			$vb_OK:=F_Report_FullDuplexMessage(False:C215; "OK"; "Report auto P "+"effectué"; "Fiches reportées : "+$vt_Temp)
			
			
			i_Message("Report auto P : "+" Transfert en cours…")
			//•Est ce une base CHRS  et y a til des fiches reportées
			$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Report auto P Transfert ")
			$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional RA")
			CLOSE WINDOW:C154
			
			
		End if 
		ARRAY LONGINT:C221(t_HGrepID; 0)
	End if 
	P_HébergementReportFindPR
End if 