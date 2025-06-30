//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 08-02-19, 02:33:59
// ----------------------------------------------------
// Method: UTL_Date_Day
// Description
// Retourne le dernier/premier jour du mois de la date $1
//
// Parameters
// $1 : date de référence
// $2 : True = dernier jour sinon premier jour du mois
// ----------------------------------------------------
C_DATE:C307($0)
C_DATE:C307($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($last_day)
C_DATE:C307($date; $date_result)

$date:=$1
$last_day:=$2

If ($last_day)
	$date_result:=Add to date:C393($date; 0; 1; -Day of:C23($date))
Else 
	$date_result:=Add to date:C393($date; 0; 0; -Day of:C23($date)+1)
End if 

$0:=$date_result