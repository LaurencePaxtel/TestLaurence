//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_PurgesReportSuivi
//{
//{          Mardi 22 mai 1997 à 11:39:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (vd_ReportPurgeDt>!00-00-00!)
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=(vd_ReportPurgeDt-1); *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
	//4/11/2008
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
	//Fin 4/11/2008
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0; *)
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		: (rJourNuit1=0) & (rJourNuit2=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
	End case 
	
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94=(<>va_RepR+"@"))
	
	MultiSoc_Filter(->[HeberGement:5])
Else 
	REDUCE SELECTION:C351([HeberGement:5]; 0)
End if 
vl_ReportPurgeNb:=Records in selection:C76([HeberGement:5])
If (<>vb_AvecProlongation)
	If (vl_ReportPurgeNb>0)
		ARRAY LONGINT:C221($tl_HGréf; vl_ReportPurgeNb)
		FIRST RECORD:C50([HeberGement:5])
		$ii:=0
		Repeat 
			$ii:=$ii+1
			If ([HeberGement:5]HG_NuitReste:95>0)
				$tl_HGréf{$ii}:=[HeberGement:5]HG_ReferenceID:1
			Else 
				
				$tl_HGréf{$ii}:=-1
				QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=[HeberGement:5]HG_HB_ID:19)
				If (Records in selection:C76([GroupeHeberges:37])=1)
					QUERY:C277([GrouPe:36]; [GrouPe:36]GP_ReferenceID:1=[GroupeHeberges:37]GH_GP_Référence:2)
					If (Records in selection:C76([GrouPe:36])=1)
						QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GrouPe:36]GP_ReferenceID:1)
						If (Records in selection:C76([Prolongation:38])>0)
							QUERY SELECTION:C341([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6=vd_ReportPurgeDt)
							If (Records in selection:C76([Prolongation:38])=1)
								$tl_HGréf{$ii}:=[HeberGement:5]HG_ReferenceID:1
							End if 
						End if 
					End if 
				End if 
			End if 
			NEXT RECORD:C51([HeberGement:5])
		Until (End selection:C36([HeberGement:5]))
		
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tl_HGréf)
	End if 
End if 
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)


FIRST RECORD:C50([HeberGement:5])
PREVIOUS RECORD:C110([HeberGement:5])
vl_ReportPurgeNb:=Records in selection:C76([HeberGement:5])