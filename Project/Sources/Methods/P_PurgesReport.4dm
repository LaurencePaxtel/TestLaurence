//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_PurgesReport
//{
//{          Lundi 21 septembre 2009 à 12:15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //Cas
//La date : vd_ReportPurgeDt
Case of 
	: ($1=0)  //Cas 0 : Reduire la sélection des hébergements à zero
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		
	: ($1=1)  //Cas 1 : Recherches des fiche de la veille ayant été reportées (avec le "R")
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
						MultiSoc_Filter(->[GroupeHeberges:37])
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
		
	: ($1=2)  //Cas 2 : Recherches des fiches du jour reportées
		If (vd_ReportPurgeDt>!00-00-00!)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ReportPurgeDt; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
			
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
			
			Case of 
				: (rJourNuit1=1) & (rJourNuit2=0)
					QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
				: (rJourNuit1=0) & (rJourNuit2=1)
					QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
			End case 
			
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92>1)
			
			MultiSoc_Filter(->[HeberGement:5])
			
		Else 
			REDUCE SELECTION:C351([HeberGement:5]; 0)
		End if 
		vl_ReportPurgeNb:=Records in selection:C76([HeberGement:5])
		
		
	: ($1=3)  //Cas 3 : Recherches des fiches du jour reportées et crées
		
	: ($1=5)  //Cas 5 : Recherches des fiches du jour reportées et Annuler le report
		//On cherche les fiche du jour crées par le report
		P_PurgesReport(2)
		If (Records in selection:C76([HeberGement:5])>0)
			If (i_Confirmer("Confirmer : pour le "+String:C10(vd_ReportPurgeDt; Interne date court:K1:7)+" sur "+String:C10(vl_ReportPurgeNb)+" fiche(s)"+<>va_CR+"      - Restitution de la disponibilité"+<>va_CR+"      - Suppression des fiches reportées"+<>va_CR+"      - Annulation du TAG <R> et <RP> du jour précédent"))
				i_Message("Annulation du report en cours…")
				
				i_MessageSeul("Annulation du report en cours : Restitution de la disponibilité")
				APPLY TO SELECTION:C70([HeberGement:5]; wUut_ReportPurgeApp1)
				
				i_MessageSeul("Annulation du report en cours : Suppression des fiches reportées           ")
				READ WRITE:C146([HeberGement:5])
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Facture:172=False:C215)
				DELETE SELECTION:C66([HeberGement:5])
				
				//On traite les fiches taguées R de la veille
				P_PurgesReport(1)
				If (Records in selection:C76([HeberGement:5])>0)
					i_MessageSeul("Annulation du report : Annulation du TAG <R> et <RP> du jour précédent ")
					APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Reporté:94:="")
					//Remettre les fiches Prolongation a faux
					QUERY:C277([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6=vd_ReportPurgeDt)
					If (Records in selection:C76([Prolongation:38])>0)
						READ WRITE:C146([Prolongation:38])
						APPLY TO SELECTION:C70([Prolongation:38]; wUut_ReportPurgeApp2)
						READ ONLY:C145([Prolongation:38])
					End if 
				End if 
				
				READ ONLY:C145([HeberGement:5])
				CLOSE WINDOW:C154
			Else 
				P_PurgesReport(1)
			End if 
		Else 
			ALERT:C41("Aucune fiche trouvée !!!")
		End if 
		
End case 