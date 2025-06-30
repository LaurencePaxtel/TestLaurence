//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_CentreLits
//{
//{          Vendrdi 26 novembre 2004 à 15:13:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283(vL_NbFiches)

vL_NbFiches:=0
REDUCE SELECTION:C351([CentresLits:16]; 0)

If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	P_SommeLit(0)
	
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
		P_SommeLit(1)
		
		ORDER BY:C49([CentresLits:16]; [LesCentres:9]LC_Nom:4; >)
		
		FIRST RECORD:C50([CentresLits:16])
		PREVIOUS RECORD:C110([CentresLits:16])
	End if 
	
End if 