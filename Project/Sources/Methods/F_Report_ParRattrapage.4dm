//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Méthode :  F_Report_ParRattrapage 
//{          Vendredi 1 août 2008 à 10:19:00
//{          Modifiée : Vendredi 9 juillet 2010 à 10:20:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)

ARRAY LONGINT:C221($tl_LesFiches; 0)

$vb_OK:=True:C214

Case of 
	: ($1=1)  //<•••>Ancienne méthode de 2008<•••>
		
		If ($vb_OK)
			$vb_OK:=([DiaLogues:3]DL_Date:2>!00-00-00!)
			$vb_OK:=$vb_OK & (vL_NbFiches>0)
			
			If ($vb_OK)
				<>vd_RAP_Base:=F_ReportLast
				<>vd_RAP_Départ:=[DiaLogues:3]DL_Date:2
				
				If (<>vd_RAP_Base>!00-00-00!) & (<>vd_RAP_Base><>vd_RAP_Départ)
					<>vd_RAP_Jusque:=<>vd_RAP_Base
				Else 
					<>vd_RAP_Jusque:=<>vd_RAP_Départ
				End if 
				
				<>vl_RAP_Jours:=<>vd_RAP_Jusque-<>vd_RAP_Départ+1
				
				If (<>vb_AvecProlongation)
					P_HébergementReportFindPR
				Else 
					P_HébergementReportFind
				End if 
				
				<>vb_RAP_CréerDispo:=False:C215
				
				va_Titre:="Rattrapage des reports"
				$vl_Fenetre:=i_FenêtreNo(466; 232; 16; va_Titre; 3; "Quit_Simple")
				
				DIALOG:C40([DiaLogues:3]; "DL_ReportRattrapage")
				$vb_OK:=(OK=1)
				
				CLOSE WINDOW:C154($vl_Fenetre)
			Else 
				ALERT:C41("Vérifiez les critères de sélection !")
			End if 
			
		End if 
		
		If ($vb_OK)
			
			//Effectuer le report
			If (i_Confirmer("Pendant le report  veuillez au paravent vous assurer"+" que personne n'est connecté !"))
				i_Message("Rattrapage du report du…")
				<>vd_RAP_Date:=<>vd_RAP_Départ
				
				For ($ii; 1; <>vl_RAP_Jours)
					i_Message("Rattrapage du report du "+String:C10(<>vd_RAP_Date))
					
					//••• Les disponibilités
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
					
					//••• Le Report      
					ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
					
					[DiaLogues:3]DL_Date:2:=<>vd_RAP_Date
					
					If (<>vb_AvecProlongation)
						P_HébergementReportFindPR
					Else 
						P_HébergementReportFind
					End if 
					
					If (<>vb_AvecProlongation)
						P_Report_RAP_AutoPR
					Else 
						P_Report_RAP_Auto([DiaLogues:3]DL_Date:2)
					End if 
					
					<>vd_RAP_Date:=<>vd_RAP_Date+1
				End for 
				
				CLOSE WINDOW:C154
				
				If (<>vb_AvecProlongation)
					P_HébergementReportFindPR
				Else 
					P_HébergementReportFind
				End if 
				
			End if 
			
		End if 
		
	: ($1=2)  //<•••>Nouvelle méthode de 2010<•••>
		
		//•••LES PARAMETRES DU RATTRAPAGE
		If ($vb_OK)
			$vb_OK:=([DiaLogues:3]DL_Date:2>!00-00-00!)
			$vb_OK:=$vb_OK & (vL_NbFiches>0)
			
			If ($vb_OK)  //Sélection initiale des hébergements   
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_LesFiches)
				
				<>vd_RAP_Base:=F_ReportLast
				<>vd_RAP_Départ:=[DiaLogues:3]DL_Date:2
				
				If (<>vd_RAP_Base>!00-00-00!) & (<>vd_RAP_Base><>vd_RAP_Départ)
					<>vd_RAP_Jusque:=<>vd_RAP_Base
				Else 
					<>vd_RAP_Jusque:=<>vd_RAP_Départ
				End if 
				
				<>vl_RAP_Jours:=<>vd_RAP_Jusque-<>vd_RAP_Départ+1
				
				<>vb_RAP_CréerDispo:=False:C215
				
				va_Titre:="Rattrapage des reports"
				$vl_Fenetre:=i_FenêtreNo(466; 252; 16; va_Titre; 3; "Quit_Simple")
				
				DIALOG:C40([DiaLogues:3]; "DL_ReportRattrapage")
				$vb_OK:=(OK=1)
				
				CLOSE WINDOW:C154($vl_Fenetre)
			Else 
				ALERT:C41("Vérifiez les critères de sélection !")
			End if 
			
		End if 
		
		//•••LA  CONFIRMATION DU RATTRAPAGE
		If ($vb_OK)
			$vb_OK:=i_Confirmer("Rattrapage : Pendant le report  veuillez au paravent vous assurer"+" que personne n'est connecté !")
		End if 
		
		//•••LE  RATTRAPAGE
		If ($vb_OK)
			i_Message("Rattrapage du report du…")
			<>vd_RAP_Date:=<>vd_RAP_Départ
			
			ARRAY LONGINT:C221(tl_RATTRAPE_Réf_HG; 0)
			
			For ($ii; 1; <>vl_RAP_Jours)
				i_Message("Rattrapage du report du "+String:C10(<>vd_RAP_Date))
				
				//••• Les disponibilités
				If (<>vb_RAP_CréerDispo)  //Avec la création des dispos
					va_DateType:=Uut_NumeroteLitsType(<>vd_RAP_Date; "J")
					
					QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
					MultiSoc_Filter(->[CentresLits:16])
					
					If (Records in selection:C76([CentresLits:16])=0)
						P_DisponibilitéNew(<>vd_RAP_Date; 0; Num:C11(<>vb_AvecProlongation))
					End if 
					
				End if 
				
				//••• Le Report      
				ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
				
				[DiaLogues:3]DL_Date:2:=<>vd_RAP_Date
				QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tl_LesFiches)
				
				If (<>vb_AvecProlongation)
					P_Report_RAP_AutoPR
				Else 
					P_Report_RAP_Auto([DiaLogues:3]DL_Date:2)
				End if 
				
				<>vd_RAP_Date:=<>vd_RAP_Date+1
				
				COPY ARRAY:C226(tl_RATTRAPE_Réf_HG; $tl_LesFiches)
				ARRAY LONGINT:C221(tl_RATTRAPE_Réf_HG; 0)
			End for 
			
			CLOSE WINDOW:C154
			
			If (<>vb_AvecProlongation)
				P_HébergementReportFindPR
			Else 
				P_HébergementReportFind
			End if 
			
		End if 
		
End case 

<>vb_RAP_CréerDispo:=False:C215
$0:=$vb_OK