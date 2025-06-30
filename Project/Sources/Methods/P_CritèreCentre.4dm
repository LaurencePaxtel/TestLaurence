//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CritèreCentre
//{
//{          Lundi 28 décembre 2009 à 10:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

Case of 
	: ($1=0)
		ARRAY TEXT:C222(ta_xCentre; 0)
		ARRAY LONGINT:C221(tl_xCentre; 0)
		ARRAY INTEGER:C220(te_xCentre; 0)
	: ($1=1)
		P_CritèreCentre(0)
		ALL RECORDS:C47([LesCentres:9])
		MultiSoc_Filter(->[LesCentres:9])
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_xCentre; [LesCentres:9]LC_Nom:4; ta_xCentre)
		ARRAY INTEGER:C220(te_xCentre; Size of array:C274(tl_xCentre))
		For ($ii; 1; Size of array:C274(tl_xCentre))
			te_xCentre{$ii}:=1
		End for 
		
	: ($1=2)
		P_CritèreCentre(0)
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=False:C215)
		MultiSoc_Filter(->[LesCentres:9])
		
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_xCentre; [LesCentres:9]LC_Nom:4; ta_xCentre)
		ARRAY INTEGER:C220(te_xCentre; Size of array:C274(tl_xCentre))
		For ($ii; 1; Size of array:C274(tl_xCentre))
			te_xCentre{$ii}:=1
		End for 
		
	: ($1=3)
		If (Size of array:C274(te_xCentre)>0)
			For ($ii; 1; Size of array:C274(tl_xCentre))
				te_xCentre{$ii}:=1
			End for 
		End if 
End case 