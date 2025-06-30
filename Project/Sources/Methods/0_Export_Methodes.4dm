//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 31/08/18, 03:20:59
// ----------------------------------------------------
// Méthode : 0_Export_Methodes
// Description
// 
//
// Paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($table_methodes; 0)

METHOD GET NAMES:C1166($table_methodes)

SORT ARRAY:C229($table_methodes; >)

0_export_table(->$table_methodes)