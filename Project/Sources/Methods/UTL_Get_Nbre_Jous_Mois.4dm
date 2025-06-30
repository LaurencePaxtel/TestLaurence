//%attributes = {}
// ----------------------------------------------------
// User name (OS): kevin HASSAL
// Date and time: 22-02-19, 08:12:07
// ----------------------------------------------------
// Method: UTL_Get_Nbre_Jous_Mois
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_DATE:C307($1)

C_LONGINT:C283($result)
C_DATE:C307($date; $date_debut; $date_fin)

$date:=$1

$date_debut:=UTL_Date_Day($date; False:C215)
$date_fin:=UTL_Date_Day($date; True:C214)

$result:=($date_fin-$date_debut)+1

$0:=$result