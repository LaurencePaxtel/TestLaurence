//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 15/12/21, 14:58:27
// ----------------------------------------------------
// Méthode : outilsTimeStampJetLag
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($0)

C_TEXT:C284($ts_t; $tsUTC_t)
C_LONGINT:C283($ts_el; $tsUTC_el)
C_DATE:C307($day_d)
C_TIME:C306($hour_h)

$day_d:=Current date:C33
$hour_h:=Current time:C178

$tsUTC_t:=String:C10($day_d; ISO date GMT:K1:10; $hour_h)  //<<< encodage UTC
$tsUTC_t:=Substring:C12($tsUTC_t; 1; 19)  //remove trailing"Z"

$ts_t:=String:C10($day_d; ISO date:K1:8; $hour_h)  //<<< encodage heure locale

XML DECODE:C1091($tsUTC_t; $day_d)
XML DECODE:C1091($tsUTC_t; $hour_h)

$tsUTC_el:=(($day_d-!2000-01-01!)*86400)+$hour_h  //86400 sec= 24h

XML DECODE:C1091($ts_t; $day_d)
XML DECODE:C1091($ts_t; $hour_h)

$ts_el:=(($day_d-!2000-01-01!)*86400)+$hour_h

$0:=$ts_el-$tsUTC_el