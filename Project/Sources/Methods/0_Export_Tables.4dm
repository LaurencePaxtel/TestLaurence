//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 31/08/18, 03:20:59
// ----------------------------------------------------
// Méthode : 0_Export_Tables
// Description
// 
//
// Paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($table_tables; 0)

For ($i; 1; Get last table number:C254)
	If (Is table number valid:C999($i))
		APPEND TO ARRAY:C911($table_tables; Table name:C256(Table:C252($i)))
	End if 
End for 

SORT ARRAY:C229($table_tables; >)

0_export_table(->$table_tables)