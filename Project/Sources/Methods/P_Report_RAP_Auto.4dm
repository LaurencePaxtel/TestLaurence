//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Dev
// Date et heure : 03/05/21, 16:52:22
// ----------------------------------------------------
// Méthode : P_Report_RAP_Auto
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_DATE:C307($1)

C_TEXT:C284($va_ii)
C_LONGINT:C283($ii; $vl_NbFiches)
C_BOOLEAN:C305($vb_OK; $vb_Report)

ARRAY LONGINT:C221(t_HGrepID; 0)

F_Report_FullDuplexTableau

$vb_OK:=F_Regional_RefsTableau(0)

If (Records in selection:C76([HeberGement:5])>0)
	vd_DateServeur:=$1
	
	SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; t_HGrepID)
	
	$vl_NbFiches:=Size of array:C274(t_HGrepID)+1
	vl_NoRéfHG:=Uut_NumerotePlus(->[HeberGement:5]; $vl_NbFiches)
	vl_NoFicheHG:=Uut_Numerote115Plus(vd_DateServeur; $vl_NbFiches)
	
	vl_NoRéfHGNb:=0
	
	$va_ii:=String:C10(Size of array:C274(t_HGrepID))
	
	For ($ii; 1; Size of array:C274(t_HGrepID))
		i_MessageSeul("Rattrapage du report du "+String:C10($1)+" : "+String:C10($ii)+"/"+$va_ii)
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=t_HGrepID{$ii})
		MultiSoc_Filter(->[HeberGement:5])
		
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
			
			If ($vb_Report)
				Va_NoUFicR:=[HeberGement:5]HG_FicheNuméro:3
				
				If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_Reporté:94="")
					
					If ([HeberGement:5]HG_NuitReste:95<=0)  // | ([HéberGement]HG_Cloturée=Faux)
						READ WRITE:C146([HeberGement:5])
						
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=Va_NoUFicR)
						MultiSoc_Filter(->[HeberGement:5])
						
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
							End if 
							
							UNLOAD RECORD:C212([HeberGement:5])
						End if 
						
						READ ONLY:C145([HeberGement:5])
					Else 
						vl_NoRéfHG:=vl_NoRéfHG+1
						vl_NoFicheHG:=vl_NoFicheHG+1
						vl_NoRéfHGNb:=vl_NoRéfHGNb+1
						
						P_ReportPasse1
						
						If (vb_IDT_TransDDASS)  // Est ce une base CHRS et y a t-il des fiches reportées : ici reunir les fiches
							$vb_OK:=True:C214
							
							If (<>vb_T_Fiches115)
								$vb_OK:=(va_IDT_TransFiche="")  //25/5/2011 (c'est pas une fiche 115)
							End if 
							
							If ($vb_OK)
								F_Report_FullReporté(->tl_Trans_Réf_HG; vl_NoRéfHG)
							End if 
							
							F_Regional_Refs(->tl_Regional_Réf_HG; vl_NoRéfHG)
						End if 
						
						// Duplication de la fiche
						P_ReportPasse2($1; vl_NoRéfHG; vl_NoFicheHG; 1)
						
						// Mise à jour de la fiche
						P_ReportPasse3(1)
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	End for 
	
	// Message sur le déroulement du Report strictement
	$vb_OK:=F_Report_FullDuplexMessage(False:C215; "OK"; "Report rattrapage "+"effectué"; "Fiches reportées : "+String:C10(Size of array:C274(tl_Trans_Réf_HG)))
	
	// Est ce une base CHRS  et y a til des fiches reportées
	$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Report rattrapage Transfert ")
	$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional RR")
	
	CLEAR VARIABLE:C89(t_HGrepID)
End if 