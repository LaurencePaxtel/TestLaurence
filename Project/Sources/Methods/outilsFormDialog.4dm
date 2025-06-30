//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 15/07/24, 18:06:57
// ----------------------------------------------------
// Méthode : outilsFormDialog
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text  // Nom du formulaire
var $2 : Object  // Position de la fenêtre créée pour afficher le formulaire
var $3 : Object  // Objet Form a mettre au lancement du formulaire

var $position_v : Variant

$position_v:=$2.position
outilsCreateWindowsForm($1; ->$position_v; $2)