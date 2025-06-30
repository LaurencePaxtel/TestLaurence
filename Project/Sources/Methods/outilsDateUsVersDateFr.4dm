//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/11/23, 16:36:12
// ----------------------------------------------------
// Méthode : outilsDateUsVersDateFr
// Description
// Passer une date au format mm-jj-aaaa vers jj/mm/aaaa
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($annee_t; $mois_t; $jour_t)

$mois_t:=Substring:C12($1; 1; 2)
$jour_t:=Substring:C12($1; 4; 2)
$annee_t:=Substring:C12($1; 7; 4)

$0:=$jour_t+"/"+$mois_t+"/"+$annee_t