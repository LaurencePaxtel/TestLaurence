//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Méthode :  F_Report_ParRattrapage2
//{          Vendredi 1 août 2008 à 10:19:00
//{          Modifiée : Jeudi 26 juiljanvierlet 2012 à 10:30:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)

C_LONGINT:C283($ii; $vl_Fenetre)
C_BOOLEAN:C305($vb_OK)
C_DATE:C307($DL_Date_Du; $DL_Date_Au)

C_BOOLEAN:C305(<>is_rattrapage)

ARRAY LONGINT:C221($tl_LesFiches; 0)

ARRAY LONGINT:C221(tb_hg_fr_referenceid; 0)
ARRAY LONGINT:C221(tl_RATTRAPE_Réf_HG; 0)

$vb_OK:=True:C214

<>is_rattrapage:=True:C214

If ($vb_OK)
	$vb_OK:=([DiaLogues:3]DL_Date:2>!00-00-00!)
	$vb_OK:=$vb_OK & (vL_NbFiches>0)
	
	If ($vb_OK)
		
		If (vb_RatrapageSelection)  // Sélection initiale des hébergements   
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_LesFiches)
		End if 
		
		<>vd_RAP_Base:=F_ReportLast
		<>vd_RAP_Départ:=[DiaLogues:3]DL_Date:2
		
		If (<>vd_RAP_Base>!00-00-00!) & (<>vd_RAP_Base><>vd_RAP_Départ)
			<>vd_RAP_Jusque:=<>vd_RAP_Base
		Else 
			<>vd_RAP_Jusque:=<>vd_RAP_Départ
		End if 
		
		<>vl_RAP_Jours:=<>vd_RAP_Jusque-<>vd_RAP_Départ+1
		
		If (vb_RatrapageSelection=False:C215)  // Sur toutes les fiches comme une balayette
			
			If (<>vb_AvecProlongation)
				P_HébergementReportFindPR
			Else 
				P_HébergementReportFind
			End if 
			
		End if 
		
		<>vb_RAP_CréerDispo:=False:C215
		
		va_Titre:="Rattrapage des reports"
		$vl_Fenetre:=i_FenêtreNo(560; 252; 16; va_Titre; 3; "Quit_Simple")
		
		DIALOG:C40([DiaLogues:3]; "DL_ReportRattrapage")
		
		$vb_OK:=(OK=1)
		CLOSE WINDOW:C154($vl_Fenetre)
	Else 
		ALERT:C41("Vérifiez les critères de sélection !")
	End if 
	
End if 

//•••LA  CONFIRMATION DU RATTRAPAGE
If ($vb_OK)
	$vb_OK:=i_Confirmer("Rattrapage "+("(Sélection)"*Num:C11(vb_RatrapageSelection))+("(Ramassage)"*Num:C11(vb_RatrapageSelection=False:C215))+" : Pendant le report  veuillez au paravent vous assurer"+" que personne n'est connecté !")
End if 

//•••LE  RATTRAPAGE
If ($vb_OK)
	i_Message("Rattrapage du report du...")
	
	<>vd_RAP_Date:=<>vd_RAP_Départ
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (03/05/2021)
	// Du fait qu'on utilise la méthode P_HébergementReportFind ici il faut modifier à la volée la valeur DL_Date_Au car on fait une boucle sur le nombre de jours
	$DL_Date_Du:=[DiaLogues:3]DL_Date:2
	
	If (Value type:C1509(DL_Date_Au)#Est une variable indéfinie:K8:13) && (DL_Date_Au#!00-00-00!)
		
		If (DL_Date_Au#!00-00-00!)
			$DL_Date_Au:=DL_Date_Au
		End if 
		
	End if 
	
	For ($ii; 1; <>vl_RAP_Jours)
		i_MessageSeul("Rattrapage du report du "+String:C10(<>vd_RAP_Date))
		
		//••• Les disponibilités
		If (<>vb_RAP_CréerDispo)  // Avec la création des dispos
			i_MessageSeul("Mise à jour des disponibilités du "+String:C10(<>vd_RAP_Date))
			
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
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (03/05/2021)
		If ($DL_Date_Au#!00-00-00!)
			DL_Date_Au:=[DiaLogues:3]DL_Date:2
		End if 
		
		If (vb_RatrapageSelection)  //26/1/2012
			QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tl_LesFiches)
			
			If (<>vb_AvecProlongation)
				P_Report_RAP_AutoPR
			Else 
				P_Report_RAP_Auto([DiaLogues:3]DL_Date:2)
			End if 
			
			<>vd_RAP_Date:=<>vd_RAP_Date+1
			
			COPY ARRAY:C226(tl_RATTRAPE_Réf_HG; $tl_LesFiches)
			ARRAY LONGINT:C221(tl_RATTRAPE_Réf_HG; 0)
		Else 
			
			If (<>vb_AvecProlongation)
				P_HébergementReportFindPR(True:C214)
			Else 
				P_HébergementReportFind(True:C214)
			End if 
			
			If (<>vb_AvecProlongation)
				P_Report_RAP_AutoPR
			Else 
				P_Report_RAP_Auto([DiaLogues:3]DL_Date:2)
			End if 
			
			<>vd_RAP_Date:=<>vd_RAP_Date+1
		End if 
		
	End for 
	
	CLOSE WINDOW:C154
	
	HG_Rattrapage_Fiches(->tb_hg_fr_referenceid)
	
	If (<>vb_AvecProlongation)
		P_HébergementReportFindPR
	Else 
		P_HébergementReportFind
	End if 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (03/05/2021)
	[DiaLogues:3]DL_Date:2:=$DL_Date_Du
	
	If ($DL_Date_Au#!00-00-00!)
		DL_Date_Au:=$DL_Date_Au
	End if 
	
	// On re-effectue la recherche initiale
	If (<>vb_AvecProlongation)
		P_HébergementReportFindPR
	Else 
		P_HébergementReportFind
	End if 
	
End if 