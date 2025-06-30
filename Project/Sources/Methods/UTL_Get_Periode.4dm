//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 27-12-18, 16:36:32
// ----------------------------------------------------
// Method: UTL_Get_Periode
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)
C_TEXT:C284($0)
C_DATE:C307($date)

If (Count parameters:C259=0)
	$date:=Current date:C33(*)
Else 
	$date:=$1->
End if 

//$0:=String(Year of($date))+"/"+String(Month of($date);"00")

$0:=String:C10(Year of:C25($date))
