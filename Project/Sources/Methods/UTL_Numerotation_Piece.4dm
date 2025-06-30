//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 27-12-18, 16:35:57
// ----------------------------------------------------
// Method: UTL_Numerotation_Piece
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)

C_TEXT:C284($periode; $prefixe)
C_LONGINT:C283($numtable)
C_BOOLEAN:C305($num_mensuelle; $num_prefixe)
C_DATE:C307($date_piece)

$numtable:=Table:C252($1)
$date_piece:=$1->

$num_mensuelle:=False:C215
$num_prefixe:=False:C215

If ($num_mensuelle)
	$periode:=UTL_Get_Periode(->$date_piece)
Else 
	$periode:=String:C10(Year of:C25($date_piece))
End if 

If (Read only state:C362([Numerotation:88]))
	READ WRITE:C146([Numerotation:88])
End if 

QUERY:C277([Numerotation:88]; [Numerotation:88]NUM_Periode:3=$periode; *)
QUERY:C277([Numerotation:88];  & ; [Numerotation:88]NUM_Table_No:4=$numtable)
MultiSoc_Filter(->[Numerotation:88])

If (Records in selection:C76([Numerotation:88])=0)
	CREATE RECORD:C68([Numerotation:88])
	[Numerotation:88]NUM_Periode:3:=$periode
	[Numerotation:88]NUM_Table_No:4:=$numtable
	
	MultiSoc_Init_Structure(->[Numerotation:88])
Else 
	UTL_Load_Record(->[Numerotation:88])
	
	If ($date_piece<[Numerotation:88]NUM_Date_Derniere_Cle:6)
		$date_piece:=[Numerotation:88]NUM_Date_Derniere_Cle:6
	End if 
	
End if 

[Numerotation:88]NUM_Date_Derniere_Cle:6:=$date_piece
[Numerotation:88]NUM_Cle:5:=[Numerotation:88]NUM_Cle:5+1

$periode:=Replace string:C233($periode; "/"; "")

If ($num_prefixe)
	$0:=ref_soc_active+"/"+$periode+String:C10([Numerotation:88]NUM_Cle:5; "00000")
Else 
	$prefixe:=Replace string:C233(UTL_Get_Periode(->$date_piece); "/"; "")
	
	$0:=$prefixe+String:C10([Numerotation:88]NUM_Cle:5; "00000")
End if 

SAVE RECORD:C53([Numerotation:88])
UNLOAD RECORD:C212([Numerotation:88])

READ ONLY:C145([Numerotation:88])