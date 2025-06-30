//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_HébergementReportFind  
//{
//{          Mardi 22 mai 1997 à 11:39:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)

If ([DiaLogues:3]DL_Date:2>!00-00-00!) | (DL_Date_Au>!00-00-00!)
	
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
	
	// 04/11/2008
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
	
	//Fin 04/11/2008
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0; *)
	
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
	
	If ([DiaLogues:3]DL_LibelléG:10>"")  // 01/08/2008
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_FamClé:104=[DiaLogues:3]DL_LibelléG:10; *)
	End if 
	
	Case of 
		: (r1=1)
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
	End case 
	
End if 

MultiSoc_Filter(->[HeberGement:5])

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
	P_HébergementReportSort
	
	FIRST RECORD:C50([HeberGement:5])
	PREVIOUS RECORD:C110([HeberGement:5])
End if 