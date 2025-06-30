//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CritèreCentreLES
//{
//{          Mardi  1 juin 2010 à 11:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($ii)

Case of 
	: ($1=0)
		ARRAY INTEGER:C220(te_LesCentre; 0)
		ARRAY LONGINT:C221(tl_LesCentre; 0)
		ARRAY TEXT:C222(ta_LesCentre; 0)
		
	: ($1=1)
		P_CritèreCentreLES(0)
		ALL RECORDS:C47([LesCentres:9])
		MultiSoc_Filter(->[LesCentres:9])
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_LesCentre; [LesCentres:9]LC_Nom:4; ta_LesCentre)
		ARRAY INTEGER:C220(te_LesCentre; Size of array:C274(tl_LesCentre))
		For ($ii; 1; Size of array:C274(tl_LesCentre))
			te_LesCentre{$ii}:=1
		End for 
		
	: ($1=3)
		P_CritèreCentreLES(0)
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=False:C215)
		
		MultiSoc_Filter(->[LesCentres:9])
		
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_LesCentre; [LesCentres:9]LC_Nom:4; ta_LesCentre)
		ARRAY INTEGER:C220(te_LesCentre; Size of array:C274(tl_LesCentre))
		For ($ii; 1; Size of array:C274(tl_LesCentre))
			te_LesCentre{$ii}:=1
		End for 
		
		
	: ($1=4)
		P_CritèreCentreLES(0)
		COPY ARRAY:C226(te_xCentre; te_LesCentre)
		COPY ARRAY:C226(tl_xCentre; tl_LesCentre)
		COPY ARRAY:C226(ta_xCentre; ta_LesCentre)
		
		
	: ($1=5)
		If (Size of array:C274(te_LesCentre)>0)
			For ($ii; 1; Size of array:C274(te_LesCentre))
				te_LesCentre{$ii}:=1
			End for 
		End if 
End case 