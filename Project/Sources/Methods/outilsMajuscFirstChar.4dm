//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Administrator
// Date et heure : 05/11/21, 10:41:03
// ----------------------------------------------------
// Méthode : outilsMajuscFirstChar
// Description
// Permet de remplacer le premier caractère d'une chaine en majuscule tout en gardant le reste de la chaine identique qu'à l'entrée
//
// Paramètres
// ----------------------------------------------------
var $0 : Text  // Chaine de caractère transformé avec le premier caractère $1 en Majuscule
var $1 : Text  // Chaine de caractère à transformer

$1:=Uppercase:C13(Substring:C12($1; 1; 1))+Substring:C12($1; 2)
$0:=$1