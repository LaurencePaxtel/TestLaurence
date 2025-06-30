//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 18-02-19, 08:02:28
// ----------------------------------------------------
// Method: WebAGL_Send_Json
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $string)

ARRAY TEXT:C222($champ; 0)
ARRAY TEXT:C222($valeur; 0)

$string:=$1

APPEND TO ARRAY:C911($champ; "X-STATUS")
APPEND TO ARRAY:C911($champ; "Cache-Control")
APPEND TO ARRAY:C911($champ; "Expires")
APPEND TO ARRAY:C911($champ; "Access-Control-Allow-Origin")

APPEND TO ARRAY:C911($valeur; "200 OK")
APPEND TO ARRAY:C911($valeur; "private, must-revalidate, max-age=0")
APPEND TO ARRAY:C911($valeur; "-1")
APPEND TO ARRAY:C911($valeur; "*")

WEB SET HTTP HEADER:C660($champ; $valeur)

WEB SEND TEXT:C677($string)