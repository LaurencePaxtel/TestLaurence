//Script CL_ListePrint : b_Imp
If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	P_SommeLit(0)
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=0)
			va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "J")
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType; *)
			MultiSoc_Filter(->[CentresLits:16])
			QUERY:C277([CentresLits:16];  & [CentresLits:16]CL_Restant:7>0)
			MultiSoc_Filter(->[CentresLits:16])
		: (rJourNuit1=0) & (rJourNuit2=1)
			va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "N")
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType; *)
			MultiSoc_Filter(->[CentresLits:16])
			QUERY:C277([CentresLits:16];  & [CentresLits:16]CL_Restant:7>0)
			MultiSoc_Filter(->[CentresLits:16])
		: (rJourNuit1=1) & (rJourNuit2=1)
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=[DiaLogues:3]DL_Date:2; *)
			MultiSoc_Filter(->[CentresLits:16])
			QUERY:C277([CentresLits:16];  & [CentresLits:16]CL_Restant:7>0)
			MultiSoc_Filter(->[CentresLits:16])
		: (rJourNuit1=0) & (rJourNuit2=0)
			REDUCE SELECTION:C351([CentresLits:16]; 0)
	End case 
	//CHERCHER DANS SELECTION([CentresLits];[CentresLits]CL_Niveau=1)`15/11/2010
	vL_NbFiches:=Records in selection:C76([CentresLits:16])
	
	If (vL_NbFiches>0)
		P_SommeLit(1)
		
		ORDER BY:C49([CentresLits:16]; [LesCentres:9]LC_Nom:4; >)
		FIRST RECORD:C50([CentresLits:16])
		_O_PAGE SETUP:C299([CentresLits:16]; "CL_CtrDisponibilité_ListeRestan")
		PRINT SETTINGS:C106
		If (OK=1)
			FORM SET OUTPUT:C54([CentresLits:16]; "CL_CtrDisponibilité_ListeRestan")
			PRINT SELECTION:C60([CentresLits:16]; *)
		End if 
	Else 
		ALERT:C41("Aucun lit restant !")
	End if 
	Rec_CentreLits
End if 