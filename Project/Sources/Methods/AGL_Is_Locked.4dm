//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/03/20, 19:06:01
// ----------------------------------------------------
// Method: AGL_Is_Locked
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($result)

$result:=False:C215

If (Locked:C147($1->))
	
	C_LONGINT:C283($vl_Process)
	C_TEXT:C284($va_User; $va_Mac; $va_Process)
	LOCKED BY:C353($1->; $vl_Process; $va_User; $va_Mac; $va_Process)
	
	ALERT:C41("Fiche occupée par "+$va_User+"")
	
End if 

$0:=$result