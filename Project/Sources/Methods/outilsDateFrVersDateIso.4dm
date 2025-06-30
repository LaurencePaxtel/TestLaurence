//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 19/05/20, 13:53:54
// ----------------------------------------------------
// Méthode : outilsDateFrVersDateIso
// Description
// Passer une date au format jj/mm/aaaa vers aaaa-mm-jj
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($annee_t; $mois_t; $jour_t)

$annee_t:=Substring:C12($1; 7; 4)
$mois_t:=Substring:C12($1; 4; 2)
$jour_t:=Substring:C12($1; 1; 2)

$0:=$annee_t+"-"+$mois_t+"-"+$jour_t