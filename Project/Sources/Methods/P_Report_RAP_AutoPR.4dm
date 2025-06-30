//%attributes = {}
C_TEXT:C284($va_ii)
C_LONGINT:C283($ii)
C_BOOLEAN:C305($vb_OK; $vb_Report; $B_Dummy)

F_Report_FullDuplexTableau
$vb_OK:=F_Regional_RefsTableau(0)

If (Records in selection:C76([HeberGement:5])>0)
	Tab_PR_data(0; 0)
	
	vd_DateServeur:=[DiaLogues:3]DL_Date:2
	
	ARRAY LONGINT:C221(t_HGrepID; 0)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; t_HGrepID)
	
	$vl_NbFiches:=Size of array:C274(t_HGrepID)+1
	
	vl_NoRéfHG:=Uut_NumerotePlus(->[HeberGement:5]; $vl_NbFiches)
	vl_NoFicheHG:=Uut_Numerote115Plus(vd_DateServeur; $vl_NbFiches)
	vl_NoRéfHGNb:=0
	
	$va_ii:=String:C10(Size of array:C274(t_HGrepID))
	
	For ($ii; 1; Size of array:C274(t_HGrepID))
		i_MessageSeul("Rattrapage du report du "+String:C10([DiaLogues:3]DL_Date:2)+" : "+String:C10($ii)+"/"+$va_ii)
		
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
		
		If (Records in selection:C76([HeberGement:5])=1)
			//========================================
			// Modified by: Kevin HASSAL (20/02/2020)
			//========================================
			// Analyse des jours de report selon les préferences de l'hébergé
			//========================================
			$vb_Report:=True:C214
			
			If (HG_Get_Reports_Config(True:C214; <>vd_RAP_Date))
				
				Case of 
					: (vl_ii=1) & (chk_dimanche)
					: (vl_ii=2) & (chk_lundi)
					: (vl_ii=3) & (chk_mardi)
					: (vl_ii=4) & (chk_mercredi)
					: (vl_ii=5) & (chk_jeudi)
					: (vl_ii=6) & (chk_vendredi)
					: (vl_ii=7) & (chk_samedi)
					Else 
						$vb_Report:=False:C215
				End case 
				
				[HeberGement:5]HG_Reporté:94:=""
			End if 
			
			Va_NoUFicR:=[HeberGement:5]HG_FicheNuméro:3
			
			If ($vb_Report)
				
				If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_Reporté:94="")
					
					If ([HeberGement:5]HG_NuitReste:95<=0)  // Est-ce que cette personne qui appartient à un groupe a une prolongation
						QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=[HeberGement:5]HG_HB_ID:19)
						
						If (Records in selection:C76([GroupeHeberges:37])=1)
							QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GroupeHeberges:37]GH_GP_Référence:2)
							
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
							
							If (Records in selection:C76([HeberGement:5])=1)
								
								If (i_NonVerrou(->[HeberGement:5]))
									[HeberGement:5]HG_Reporté:94:=<>va_RepF
									[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
									
									// Modifié par : Scanu Rémy (05/10/2023)
									[HeberGement:5]HG_TimeStamp:180:=outilsTimeStamp(Current date:C33(*); Current time:C178(*))
									
									// Modifié par : Scanu Rémy (09/11/2023)
									// Mise en place d'un booléen pour savoir si la sauvegarde provient de l'application mobile ou pas
									[HeberGement:5]importApplicationMobile:184:=False:C215
									SAVE RECORD:C53([HeberGement:5])
									
									UNLOAD RECORD:C212([HeberGement:5])
								Else 
									UNLOAD RECORD:C212([HeberGement:5])
								End if 
								
							End if 
							
							READ ONLY:C145([HeberGement:5])
						End if 
						
					Else   //  Si ([HéberGement]HG_NuitReste<=0)            
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
							
							$B_Dummy:=F_Regional_Refs(->tl_Regional_Réf_HG; vl_NoRéfHG)
						End if   // FIN ici reunir les fiches reportées
						
						P_ReportPasse2([DiaLogues:3]DL_Date:2; vl_NoRéfHG; vl_NoFicheHG; 1)
						P_ReportPasse3(1)
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	End for 
	
	//Mise à jour des prolongations
	P_ReportPasse4MàJPro([DiaLogues:3]DL_Date:2; 0)
	Tab_PR_data(0; 0)
	
	//Message sur le déroulement du Report strictement
	$vb_OK:=F_Report_FullDuplexMessage(False:C215; "OK"; "Report rattrapage P "+"effectué"; "Fiches reportées : "+String:C10(Size of array:C274(tl_Trans_Réf_HG)))
	
	//•Est ce une base CHRS  et y a til des fiches reportées
	$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Report rattrapage P Transfert ")
	$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional RR")
	
	ARRAY LONGINT:C221(t_HGrepID; 0)
End if 