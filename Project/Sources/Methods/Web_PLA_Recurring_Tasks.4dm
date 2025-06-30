//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 08/04/20, 08:01:03
// ----------------------------------------------------
// Method: Web_PLA_Recurring_Tasks
// Description
// Tâches récurrentes : planning web
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($days; $i)
C_DATE:C307($current_date; $end_date)

While (True:C214)
	$current_date:=Current date:C33
	
	$end_date:=Add to date:C393($current_date; 0; 6; 0)
	$days:=$end_date-$current_date
	
	For ($i; 1; $days)
		Web_PLA_RT_Create($current_date)
		
		$current_date:=Add to date:C393($current_date; 0; 0; 1)
	End for 
	
	DELAY PROCESS:C323(Current process:C322; UTL_Ticks_Remaining(?01:00:00?))
End while 