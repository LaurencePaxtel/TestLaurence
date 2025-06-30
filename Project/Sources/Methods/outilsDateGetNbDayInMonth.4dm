//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 22/07/24, 15:03:55
// ----------------------------------------------------
// Méthode : outilsDateGetNbDayInMonth
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Integer
var $1 : Date

var $date_d : Date

$date_d:=outilsPremierDuMois($1)
$dateFin_d:=outilsDernierDuMois($1)

$0:=($dateFin_d-$date_d)+1