//%attributes = {}
C_LONGINT:C283($1)
If ($1>0)
	QUERY:C277([RenseiGnements:20]; [RenseiGnements:20]RG_HB_ID:2=$1)
	MultiSoc_Filter(->[RenseiGnements:20])
	ORDER BY:C49([RenseiGnements:20]; [RenseiGnements:20]RG_Date:3; <; *)
	ORDER BY:C49([RenseiGnements:20]; [RenseiGnements:20]RG_Heure:4; <)
	FIRST RECORD:C50([RenseiGnements:20])
	PREVIOUS RECORD:C110([RenseiGnements:20])
Else 
	REDUCE SELECTION:C351([RenseiGnements:20]; 0)
End if 
vL_Nb_HG_F:=Records in selection:C76([RenseiGnements:20])