//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 19/05/20, 13:53:54
// ----------------------------------------------------
// Méthode : outilsDateIsoVersDateFr
// Description
// Passer une date au format aaaa-mm-jj vers jj/mm/aaaa
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($0)

C_TEXT:C284($annee_t; $mois_t; $jour_t)

$annee_t:=Substring:C12($1; 0; 4)
$mois_t:=Substring:C12($1; 6; 2)
$jour_t:=Substring:C12($1; 9; 2)

$0:=$jour_t+"/"+$mois_t+"/"+$annee_t