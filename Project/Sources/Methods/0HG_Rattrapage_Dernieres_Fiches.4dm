//%attributes = {}
// ----------------------------------------------------
// User name (OS): KEVIN HASSAL
// Date and time: 05/20/20, 10:22:01
// ----------------------------------------------------
// Method: HG_Rattrapage_Dernieres_Fiches
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

ARRAY LONGINT:C221($tb_ids; 0)

COPY ARRAY:C226($1->; $tb_ids)

For ($i; 1; Size of array:C274($tb_ids))
	READ WRITE:C146([HeberGement:5])
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Origine_ID:175=$tb_ids{$i}; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94="R")
	MultiSoc_Filter(->[HeberGement:5])
	
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
	
	While (Locked:C147([HeberGement:5]))
		LOAD RECORD:C52([HeberGement:5])
	End while 
	
	[HeberGement:5]HG_Reporté:94:=""
	
	SAVE RECORD:C53([HeberGement:5])
	UNLOAD RECORD:C212([HeberGement:5])
End for 

UNLOAD RECORD:C212([HeberGement:5])
READ ONLY:C145([HeberGement:5])