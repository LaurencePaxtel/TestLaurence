//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 02:59:23
// ----------------------------------------------------
// Méthode : UTL_champ
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_POINTER:C301($1; $champ)

$champ:=$1

$0:="T"+String:C10(Table:C252($champ))+"|C"+String:C10(Field:C253($champ))
