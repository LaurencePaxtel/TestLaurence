//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Report_Auto
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($vl_NbFiches; vL_NbSortants; vl_NbFichesReport)

F_Report_FullDuplexTableau
$vb_OK:=F_Regional_RefsTableau(0)

vl_NbFichesReport:=0

If (Records in selection:C76([HeberGement:5])>0)
	i_Message("Recherche en cours…")
	
	vd_DateServeur:=!00-00-00!
	vl_CHJx:=0
	vl_CHNx:=0
	va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "J")
	vd_DateServeur:=[DiaLogues:3]DL_Date:2
	
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
	
	// 04/11/2008
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)
	QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin)
	// Fin 04/11/2008
	
	vl_CHJx:=Records in selection:C76([CentresLits:16])
	va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "N")
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
	
	// 04/11/2008
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)
	QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin)
	
	MultiSoc_Filter(->[CentresLits:16])
	// Fin 04/11/2008
	
	vl_CHNx:=Records in selection:C76([CentresLits:16])
	CLOSE WINDOW:C154
	
	If (vl_CHNx<=0) | (vl_CHNx<=0)
		ALERT:C41("Vous devez saisir les disponibilités.")
	Else 
		ARRAY LONGINT:C221(t_HGrepID; 0)
		
		If (i_Confirmer("Confirmez-vous le report automatique ?"))
			i_Message("Report automatique en cours…")
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; t_HGrepID)
			
			// Nouvelle méthode le 12 avril 2005
			$vl_NbFiches:=Size of array:C274(t_HGrepID)+1
			
			vl_NoRéfHG:=Uut_NumerotePlus(->[HeberGement:5]; $vl_NbFiches)
			vl_NoFicheHG:=Uut_Numerote115Plus(vd_DateServeur; $vl_NbFiches)
			
			vl_NoRéfHGNb:=0
			
			For ($ii; 1; Size of array:C274(t_HGrepID))
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=t_HGrepID{$ii})
				MultiSoc_Filter(->[HeberGement:5])
				
				If (Records in selection:C76([HeberGement:5])=1)
					Va_NoUFicR:=[HeberGement:5]HG_FicheNuméro:3
					
					If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_Reporté:94="")
						
						If ([HeberGement:5]HG_NuitReste:95<=0)
							READ WRITE:C146([HeberGement:5])
							
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=Va_NoUFicR)
							MultiSoc_Filter(->[HeberGement:5])
							
							If (Records in selection:C76([HeberGement:5])=1)
								
								If (i_NonVerrou(->[HeberGement:5]))
									[HeberGement:5]HG_Reporté:94:=<>va_RepF
									[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
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
							
							// •Est ce une base CHRS  et y a til des fiches reportées :  ici reunir les fiches 
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
							
							P_ReportPasse2([DiaLogues:3]DL_Date:2; vl_NoRéfHG; vl_NoFicheHG; 1)
							vl_NbFichesReport:=vl_NbFichesReport+1
							
							P_ReportPasse3(1)
						End if 
						
					End if 
					
				End if 
				
			End for 
			
			CLOSE WINDOW:C154
			
			$vt_Temp:="Fiches reportées : "+String:C10(vl_NbFichesReport)
			P_HébergementSortant(5)
			
			If (<>vb_M_MailOui)
				$vb_OK:=F_MailReport_Corps(3)
				
				$vt_Temp:=$vt_Temp+Char:C90(13)+Char:C90(13)
				$vt_Temp:=$vt_Temp+"Liste des personnes en fin d'hébergement : "+String:C10(vL_NbSortants)
			End if 
			
			$vb_OK:=F_Report_FullDuplexMessage(False:C215; "OK"; "Report auto"+"effectué"; $vt_Temp)
			
			i_Message("Report auto : "+" Transfert en cours…")
			
			//•Est ce une base CHRS et y a t-il des fiches reportées ?
			$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Report auto Transfert ")
			$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional RA")
			CLOSE WINDOW:C154
		End if 
		
		ARRAY LONGINT:C221(t_HGrepID; 0)
	End if 
	
	P_HébergementReportFind
End if 