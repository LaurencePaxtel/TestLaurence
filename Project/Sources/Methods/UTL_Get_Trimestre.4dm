//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 19-12-18, 09:22:36
// ----------------------------------------------------
// Method: UTL_Get_Trimestre
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_DATE:C307($1; $date)
C_LONGINT:C283($0; $result; $month)

$date:=$1

$month:=Month of:C24($date)

Case of 
	: (($month=1) | ($month=2) | ($month=3))
		
		$result:=1
		
	: (($month=4) | ($month=5) | ($month=6))
		
		$result:=2
		
	Else 
		
		$result:=3
		
End case 

$0:=$result