//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbLits
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

CREATE EMPTY SET:C140([CentresLits:16]; "E_CLCourant")
If (vd_Date1=vd_Date2)
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=vd_Date1; *)
Else 
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3>=vd_Date1; *)
	QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_Date:3<=vd_Date2; *)
End if 
If (((rJourNuit1=1) & (rJourNuit2=1)) | ((rJourNuit1=0) & (rJourNuit2=0)))
Else 
	If (rJourNuit1=1)
		QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_Type:8="J"; *)
	End if 
	If (rJourNuit2=1)
		QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_Type:8="N"; *)
	End if 
End if 

QUERY:C277([CentresLits:16])
MultiSoc_Filter(->[CentresLits:16])

CREATE SET:C116([CentresLits:16]; "E_CLCourant")
USE SET:C118("E_CLCourant")