//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_HébergementReportFindPR
//{
//{          Lundi 13 septembre 2004 à 15:18:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii)

If ([DiaLogues:3]DL_Date:2>!00-00-00!) | (DL_Date_Au>!00-00-00!)
	//CHERCHER([HeberGement];[HeberGement]HG_Date=([DiaLogues]DL_Date-1);*)
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (30/03/2021)
	If ([DiaLogues:3]DL_Date:2>!00-00-00!)  // Il y a une date de début
		
		Case of 
			: ([DiaLogues:3]DL_Date:2=DL_Date_Au)  // Il y a une date de fin qui est égal à la date de début
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=([DiaLogues:3]DL_Date:2-1); *)
			: (DL_Date_Au>!00-00-00!)  // Il y a une date de fin
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=[DiaLogues:3]DL_Date:2; *)
			Else   // Il n'y a qu'une date de début
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=([DiaLogues:3]DL_Date:2-1); *)
		End case 
		
	End if 
	
	If (DL_Date_Au>!00-00-00!)  // Il y a une date de fin
		
		Case of 
			: (DL_Date_Au=[DiaLogues:3]DL_Date:2)  // Il y a une date de début qui est égal à la date de fin (traité en haut)
			: ([DiaLogues:3]DL_Date:2>!00-00-00!)  // Il y a aussi une date de début
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<DL_Date_Au; *)
			Else   // Il n'y a qu'une date de fin
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=(DL_Date_Au-1); *)
		End case 
		
	End if 
	
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
	
	//4/11/2008
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
	
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		: (rJourNuit1=0) & (rJourNuit2=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
	End case 
	
	If ([DiaLogues:3]DL_Libellé:3>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21=([DiaLogues:3]DL_Libellé:3+"@"); *)
	End if 
	
	If ([DiaLogues:3]DL_LibelPlus:6>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_CentreNom:62=([DiaLogues:3]DL_LibelPlus:6+"@"); *)
	End if 
	
	If ([DiaLogues:3]DL_LibelléG:10>"")  //1/8/2008
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_FamClé:104=[DiaLogues:3]DL_LibelléG:10; *)
	End if 
	
	Case of 
		: (r1=1)  //Tous
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]ID:168#0)
		: (r2=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94=<>va_RepR)
		: (r3=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94="")
		: (r4=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94=<>va_RepF)
		: (r5=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94=<>va_RepA)
		: (r6=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94=<>va_RepR)
		: (r7=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Status:89=True:C214)
		: (r8=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_ER_Excuse:124=True:C214)
		: (r9=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94=(<>va_RepR+"@"))
		: (r10=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_AutreSolutio:88=<>va_SADAutresolution)
		: (r11=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95=0)
	End case 
	
	MultiSoc_Filter(->[HeberGement:5])
End if 

//==========================================//
// Modified by: Kevin HASSAL (03/03/2020)
// Pour prendre en compte les reports semaines
//==========================================//
If (Count parameters:C259>0)
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Reports_Semaine:176=False:C215)
	
	CREATE SET:C116([HeberGement:5]; "$selection_A")
	P_HébergementReportFind_Semaine
	
	CREATE SET:C116([HeberGement:5]; "$selection_B")
	UNION:C120("$selection_A"; "$selection_B"; "$result")
	
	USE SET:C118("$result")
	
	CLEAR SET:C117("$selection_A")
	CLEAR SET:C117("$selection_B")
	
	CLEAR SET:C117("$result")
End if 
//==========================================//

vL_NbFiches:=Records in selection:C76([HeberGement:5])
If (vL_NbFiches>0)
	ARRAY LONGINT:C221($tl_HGréf; vL_NbFiches)
	
	FIRST RECORD:C50([HeberGement:5])
	
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
						QUERY SELECTION:C341([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6=[DiaLogues:3]DL_Date:2)
						
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
	
	P_HébergementReportSort
	
	FIRST RECORD:C50([HeberGement:5])
	PREVIOUS RECORD:C110([HeberGement:5])
	
	vL_NbFiches:=Records in selection:C76([HeberGement:5])
End if 