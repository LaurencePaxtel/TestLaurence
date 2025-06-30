//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 21/10/18, 09:05:44
// ----------------------------------------------------
// Méthode : WEB_UTL_format_js
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($1; $string)

$string:=$1

$string:=Replace string:C233($string; "\n"; "\\n")
$string:=Replace string:C233($string; "\r"; "\\r")
$string:=Replace string:C233($string; "\t"; "\\t")
//$string:=Remplacer chaine($string;"{";"\\{")
//$string:=Remplacer chaine($string;"}";"\\}")
//$string:=Remplacer chaine($string;"[";"\\[")
//$string:=Remplacer chaine($string;"]";"\\]")
//$string:=Remplacer chaine($string;"(";"\\(")
//$string:=Remplacer chaine($string;")";"\\)")
//$string:=Remplacer chaine($string;":";"\\:")

$string:=Replace string:C233($string; "'"; "\\'")

$0:=$string

