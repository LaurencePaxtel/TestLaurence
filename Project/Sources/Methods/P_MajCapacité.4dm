//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_MajCapacité
//{
//{          Mardi 30 Novembre 2004 à 14:33
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[CentresLits:16]CL_LC_ID:2)
MultiSoc_Filter(->[LesCentres:9])
If (Records in selection:C76([LesCentres:9])=1)
	If ([CentresLits:16]CL_Type:8="J")
		[CentresLits:16]CL_Capacité:4:=[LesCentres:9]LC_DispoJour:48
	Else 
		[CentresLits:16]CL_Capacité:4:=[LesCentres:9]LC_DispoNuit:22
	End if 
End if 