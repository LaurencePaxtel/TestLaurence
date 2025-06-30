//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Faxer_DASS
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

_O_PAGE SETUP:C299([DePart:1]; "Fi_Stat1")
i_Message("Faxer les éléments statistiques.")
PRINT SETTINGS:C106
CLOSE WINDOW:C154
If (OK=1)
	
	READ ONLY:C145([DePart:1])
	READ ONLY:C145([LesCentres:9])
	QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
	MultiSoc_Filter(->[DePart:1])
	If (Records in selection:C76([DePart:1])>0)
		
		FORM SET OUTPUT:C54([DePart:1]; "Fi_Stat0")
		PRINT SELECTION:C60([DePart:1]; *)
		
		FORM SET OUTPUT:C54([DePart:1]; "Fi_Stat1")
		PRINT SELECTION:C60([DePart:1]; *)
		
		FORM SET OUTPUT:C54([DePart:1]; "Fi_Stat4")
		PRINT SELECTION:C60([DePart:1]; *)
		
		ALL RECORDS:C47([LesCentres:9])
		MultiSoc_Filter(->[LesCentres:9])
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		FIRST RECORD:C50([LesCentres:9])
		FORM SET OUTPUT:C54([DePart:1]; "Fi_Stat2")
		PRINT SELECTION:C60([DePart:1]; *)
		
		
		FORM SET OUTPUT:C54([DePart:1]; "Fi_Stat3")
		PRINT SELECTION:C60([DePart:1]; *)
	End if 
End if 
