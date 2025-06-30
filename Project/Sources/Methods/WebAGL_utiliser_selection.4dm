//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 00:16:35
// ----------------------------------------------------
// Méthode : WebAGL_utiliser_selection
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($w_action; $1)
$w_action:=$1

USE NAMED SELECTION:C332("<>"+w_structure+"_"+$w_action+"_"+String:C10(w_userUID)+"_Selection")