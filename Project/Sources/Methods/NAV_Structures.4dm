//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 27/08/18, 00:49:57
// ----------------------------------------------------
// Méthode : NAV_Structures
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($position_t)

$position_t:="center"
outilsCreateWindowsForm("Saisie_Liste"; ->$position_t; New object:C1471("entitySelection"; ds:C1482.Structures.all()); ->[Structures:79])