//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 22/09/2020, 06:34:35
// ----------------------------------------------------
// Method: LB_Field_Header_Clean
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($texte; $1)

$texte:=$1

$texte:=Replace string:C233($texte; "*"; "")
$texte:=Replace string:C233($texte; "/"; "")
$texte:=Replace string:C233($texte; "_"; "")
$texte:=Replace string:C233($texte; "-"; "")
$texte:=Replace string:C233($texte; "'"; "")
$texte:=Replace string:C233($texte; "."; "")
$texte:=Replace string:C233($texte; ","; "")
$texte:=Replace string:C233($texte; ";"; "")
$texte:=Replace string:C233($texte; ":"; "")

$0:=$texte