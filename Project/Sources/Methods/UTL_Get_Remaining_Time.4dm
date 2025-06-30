//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/04/20, 10:20:01
// ----------------------------------------------------
// Method: UTL_Get_Remaining_Time
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $seconds; $remaining_days; $remaining_hours; $remaining_minutes)
C_LONGINT:C283($SECONDS_PER_MINUTE; $SECONDS_PER_HOUR; $SECONDS_PER_DAY)
C_TEXT:C284($0; $result)

$seconds:=$1
$result:=""

// Constantes
$SECONDS_PER_MINUTE:=60
$SECONDS_PER_HOUR:=3600
$SECONDS_PER_DAY:=86400

$remaining_days:=Int:C8($seconds/$SECONDS_PER_DAY)
$remaining_hours:=Int:C8(Mod:C98($seconds; $SECONDS_PER_DAY)/$SECONDS_PER_HOUR)
$remaining_minutes:=Int:C8(Mod:C98(Mod:C98($seconds; $SECONDS_PER_DAY); $SECONDS_PER_HOUR)/$SECONDS_PER_MINUTE)
$remaining_seconds:=Int:C8(Mod:C98(Mod:C98(Mod:C98($seconds; $SECONDS_PER_DAY); $SECONDS_PER_HOUR); $SECONDS_PER_MINUTE))

If ($remaining_days>0)
	$result:=$result+String:C10($remaining_days)
	If ($remaining_days>1)
		$result:=$result+" jours"
	Else 
		$result:=$result+" jour"
	End if 
End if 

If ($remaining_hours>0)
	$result:=$result+" "+String:C10($remaining_hours)
	If ($remaining_hours>1)
		$result:=$result+" heures"
	Else 
		$result:=$result+" heure"
	End if 
End if 

If ($remaining_days=0)
	If ($remaining_minutes>0)
		$result:=$result+" "+String:C10($remaining_minutes)
		If ($remaining_minutes>1)
			$result:=$result+" minutes"
		Else 
			$result:=$result+" minute"
		End if 
	End if 
End if 

If ($result="")
	If ($remaining_seconds>0)
		$result:=$result+" "+String:C10($remaining_seconds)
		If ($remaining_seconds>1)
			$result:=$result+" secondes"
		Else 
			$result:=$result+" seconde"
		End if 
	End if 
End if 

$0:=$result