//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ReportRetard
//{
//{          Lundi 12 janvier 2004 à 17:36:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)

C_LONGINT:C283($ii)
C_BOOLEAN:C305($vb_OK)

F_Report_FullDuplexTableau
$vb_OK:=F_Regional_RefsTableau(0)

If (Records in selection:C76([HeberGement:5])>0)
	i_Message("Recherche en cours…")
	
	vl_CHJx:=0
	vl_CHNx:=0
	va_DateType:=Uut_NumeroteLitsType($1; "J")
	
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
	
	//4/11/2008
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)
	QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin)
	//Fin 4/11/2008
	
	MultiSoc_Filter(->[CentresLits:16])
	vl_CHJx:=Records in selection:C76([CentresLits:16])
	
	CLOSE WINDOW:C154
	
	If (vl_CHNx<=0)
		// Création des disponibilités 
		P_CL_LitsReports($1)
		
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
		
		//4/11/2008
		QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)
		QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin)
		//Fin 4/11/2008
		
		MultiSoc_Filter(->[CentresLits:16])
		vl_CHJx:=Records in selection:C76([CentresLits:16])
	End if 
	
	If (vl_CHJx>0)
		i_Message("Report automatique du "+String:C10($1)+" en cours…")
		P_ReportRec1($1)
		
		ARRAY LONGINT:C221(t_HGrepID; 0)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; t_HGrepID)
		
		vl_NoRéfHG:=Uut_Numerote(->[HeberGement:5])
		vl_NoFicheHG:=Uut_Numerote115(vd_DateServeur)
		vl_NoRéfHGNb:=0
		
		For ($ii; 1; Size of array:C274(t_HGrepID))
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
						
						//•Est ce une base CHRS  et y a til des fiches reportées :  ici reunir les fiches 
						If (vb_IDT_TransDDASS)
							$vb_OK:=True:C214
							
							If (<>vb_T_Fiches115)
								$vb_OK:=(va_IDT_TransFiche="")  //25/5/2011 (c'est pas une fiche 115)
							End if 
							
							If ($vb_OK)
								F_Report_FullReporté(->tl_Trans_Réf_HG; vl_NoRéfHG)
							End if 
							
							$vb_OK:=F_Regional_Refs(->tl_Regional_Réf_HG; vl_NoRéfHG)
						End if 
						//FIN ici reunir les fiches reportées            
						
						P_ReportPasse2($1; vl_NoRéfHG; vl_NoFicheHG; 1)
						P_ReportPasse3(1)
					End if 
					
				End if 
				
			End if 
			
		End for 
		
		vl_NoRéfHG:=Uut_NumerotePlus(->[HeberGement:5]; vl_NoRéfHGNb)
		var $vaCPT_115 : Text
		$vaCPT_115:=Storage:C1525.numerotation.vaCPT_115
		vl_NoFicheHG:=Uut_NumerotePlus(->$vaCPT_115; vl_NoRéfHGNb)
		
		//Message sur le déroulement du Report strictement
		$vb_OK:=F_Report_FullDuplexMessage(False:C215; "OK"; "Report Retard "+"effectué"; "Fiches reportées : "+String:C10(Size of array:C274(tl_Trans_Réf_HG)))
		
		i_MessageSeul("Report automatique du "+String:C10($1)+" Transfert en cours…")
		
		//•Est ce une base CHRS et y a t-il des fiches reportées ?
		$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; vb_Serveur; "Report Retard Transfert")
		$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional RRT")
		
		CLOSE WINDOW:C154
		ARRAY LONGINT:C221(t_HGrepID; 0)
	End if 
	
End if 