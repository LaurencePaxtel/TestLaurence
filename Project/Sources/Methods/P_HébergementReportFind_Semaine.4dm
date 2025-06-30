//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 03/03/2020, 13:59:03
// ----------------------------------------------------
// Method: P_HébergementReportFind_Semaine
// Description
// Pour prendre en compte les reports semaines
//
// Parameters
// ----------------------------------------------------

If (<>vd_RAP_Départ>!00-00-00!)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=(<>vd_RAP_Départ-1); *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reports_Semaine:176=True:C214; *)
	
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
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
	
	If ([DiaLogues:3]DL_LibelléG:10>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_FamClé:104=[DiaLogues:3]DL_LibelléG:10; *)
	End if 
	
	QUERY:C277([HeberGement:5])
End if 

MultiSoc_Filter(->[HeberGement:5])