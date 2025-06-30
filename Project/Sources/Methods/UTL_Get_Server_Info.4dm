//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 11:39:13
// ----------------------------------------------------
// Method: UTL_Get_Server_Info
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($type; $ip_address; $subnet)

$type:=$1

Case of 
	: ($type="ip")
		IT_MyTCPAddr($ip_address; $subnet)
End case 

$0:=$ip_address