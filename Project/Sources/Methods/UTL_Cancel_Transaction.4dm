//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 11/03/20, 17:41:00
// ----------------------------------------------------
// Method: UTL_Cancel_Transaction
// Description
// Cancel transaction if there is any
// 
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i)

For ($i; 1; Transaction level:C961)
	CANCEL TRANSACTION:C241
End for 