//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 17/04/24, 15:59:36
// ----------------------------------------------------
// Méthode : outilsHeureIsoVersHeureFr
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Text
var $1 : Text

var $heure_t : Text

$heure_t:=Substring:C12($1; Position:C15("T"; $1)+1)
$heure_t:=Substring:C12($heure_t; 1; Position:C15("."; $heure_t)-1)

$0:=$heure_t