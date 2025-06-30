//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_BAL_E
//{
//{          Lundi 26 février 2007 à 18:34:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_BOOLEAN:C305($vb_OK)
C_BOOLEAN:C305($vb_Creation)
C_LONGINT:C283($ii)
$vb_OK:=False:C215
$vb_Creation:=False:C215
Case of 
	: ($1=1)
		//◊vd_Trans_FicheDate : date de la fiche
		//◊vd_Trans_LastReportDate : date des derières fiches
		//◊ve_Trans_NuitTotal : total des nuits attribuées auquel il faudra enlever la 1èr
		//Restent à reporter de 1 à 365 jours et plus
		//Mais on ne peut reporter que jusqu'à la date du dernier report '◊vd_Trans_LastRe
		
		<>vl_RAP_Jours:=0
		If (<>vd_Trans_FicheDate>=<>vd_Trans_LastReportDate)
			$vb_OK:=False:C215
		Else 
			$vb_OK:=((<>ve_Trans_NuitTotal-1)>0)
		End if 
		If ($vb_OK)
			$ii:=0
			Repeat 
				$ii:=$ii+1
			Until (Add to date:C393(<>vd_Trans_FicheDate; 0; 0; $ii)=<>vd_Trans_LastReportDate)
			<>vl_RAP_Jours:=$ii
		End if 
		
		
		
		If (<>vl_RAP_Jours>0)
			//"Rattrapage des reports"
			<>vb_RAP_CréerDispo:=False:C215
			<>vd_RAP_Départ:=Add to date:C393(<>vd_Trans_FicheDate; 0; 0; 1)
			<>vd_RAP_Date:=<>vd_RAP_Départ
			
			i_Message("Rattrapage du report du "+String:C10(<>vd_RAP_Date))
			
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=<>vl_Trans_HébergementRéf)
			MultiSoc_Filter(->[HeberGement:5])
			vL_NbFiches:=Records in selection:C76([HeberGement:5])
			
			
			For ($ii; 1; <>vl_RAP_Jours)
				If (<>vb_RAP_CréerDispo)  //Avec la création des dispos
					i_MessageSeul("Mise à jour des disponibilités du "+String:C10(<>vd_RAP_Date))
					va_DateType:=Uut_NumeroteLitsType(<>vd_RAP_Date; "J")
					QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
					MultiSoc_Filter(->[CentresLits:16])
					If (Records in selection:C76([CentresLits:16])=0)
						P_DisponibilitéNew(<>vd_RAP_Date; 0; Num:C11(<>vb_AvecProlongation))
					End if 
				End if 
				i_MessageSeul("Rattrapage du report du "+String:C10(<>vd_RAP_Date))
				ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
				//[DiaLogues]DL_Date:=◊vd_RAP_Date
				
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=<>vl_Trans_HébergéRéf; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=(<>vd_RAP_Date-1); *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214)
				MultiSoc_Filter(->[HeberGement:5])
				vL_NbFiches:=Records in selection:C76([HeberGement:5])
				FIRST RECORD:C50([HeberGement:5])
				P_Report_RAP_Auto(<>vd_RAP_Date)
				<>vd_RAP_Date:=<>vd_RAP_Date+1
			End for 
			
			CLOSE WINDOW:C154
		End if 
End case 