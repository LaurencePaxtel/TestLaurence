//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_CL_Dispo
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	vl_LC_sCapa:=0
	vl_LC_sRep:=0
	vl_LC_sExc:=0
	vl_LC_sRpl:=0
	vl_LC_sSor:=0
	vl_LC_sDpJ:=0
	vl_LC_sDpT:=0
	vl_LC_sDist:=0
	vl_LC_sRest:=0
	vl_LC_sAbsJ:=0
	vl_LC_sExc:=0
	vl_LC_sSor:=0
	vl_LC_sRveil:=0
	
	vl_LC_sRest115:=0
	vl_LC_sRestCtr:=0
	vl_LC_sRestTotal:=0
	
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=0)
			va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "J")
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
		: (rJourNuit1=0) & (rJourNuit2=1)
			va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "N")
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
		: (rJourNuit1=1) & (rJourNuit2=1)
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=[DiaLogues:3]DL_Date:2)
		: (rJourNuit1=0) & (rJourNuit2=0)
			REDUCE SELECTION:C351([CentresLits:16]; 0)
	End case 
	MultiSoc_Filter(->[CentresLits:16])
	vL_NbFiches:=Records in selection:C76([CentresLits:16])
	If (vL_NbFiches>0)
		
		vl_LC_sCapa:=Sum:C1([CentresLits:16]CL_Capacité:4)
		vl_LC_sRep:=Sum:C1([CentresLits:16]CL_Report:11)
		vl_LC_sDpJ:=Sum:C1([CentresLits:16]CL_DispoDuJour:12)
		vl_LC_sDpT:=Sum:C1([CentresLits:16]CL_DispoTotal:5)
		vl_LC_sDist:=Sum:C1([CentresLits:16]CL_Distribué:6)
		vl_LC_sRest:=Sum:C1([CentresLits:16]CL_Restant:7)
		vl_LC_sAbsJ:=Sum:C1([CentresLits:16]CL_Absents:13)
		vl_LC_sExc:=Sum:C1([CentresLits:16]CL_Excusés:14)
		vl_LC_sRpl:=Sum:C1([CentresLits:16]CL_Remplacants:28)
		vl_LC_sSor:=Sum:C1([CentresLits:16]CL_Sortants:15)
		vl_LC_sRveil:=Sum:C1([CentresLits:16]CL_RestantsVeille:16)
		
		
		ORDER BY:C49([CentresLits:16]; [LesCentres:9]LC_Nom:4; >)
		FIRST RECORD:C50([CentresLits:16])
		PREVIOUS RECORD:C110([CentresLits:16])
	Else 
		REDUCE SELECTION:C351([CentresLits:16]; 0)
	End if 
Else 
	REDUCE SELECTION:C351([CentresLits:16]; 0)
	vL_NbFiches:=0
End if 