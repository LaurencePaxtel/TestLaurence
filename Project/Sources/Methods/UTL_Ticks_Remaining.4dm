//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 10/04/20, 08:48:03
// ----------------------------------------------------
// Method: UTL_Ticks_Remaining
// Description
// Pour récupérér le nombre des ticks restant
// pour le déclenchement du cron job dans une
// heure donnée
//
// Parameters
// $1 : Heure du déclenchement souhaitée
// ----------------------------------------------------

C_TIME:C306($1)
C_REAL:C285($time_exec; $now; $ticks_remaining_day)

$time_exec:=$1*1  // convert to seconds
$now:=Current time:C178*1

If ($time_exec>=$now)
	$ticks_remaining_day:=$time_exec-$now*60
Else 
	$ticks_remaining_day:=((?24:00:00?*1)-$now+$time_exec)*60
End if 

$0:=$ticks_remaining_day