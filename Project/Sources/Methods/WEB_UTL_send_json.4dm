//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 00:15:55
// ----------------------------------------------------
// Méthode : WEB_UTL_send_json
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

ARRAY TEXT:C222($champ; 0)
ARRAY TEXT:C222($valeur; 0)

APPEND TO ARRAY:C911($champ; "X-STATUS")
APPEND TO ARRAY:C911($champ; "Cache-Control")
APPEND TO ARRAY:C911($champ; "Expires")
APPEND TO ARRAY:C911($champ; "Access-Control-Allow-Origin")

APPEND TO ARRAY:C911($valeur; "200 OK")
APPEND TO ARRAY:C911($valeur; "private, must-revalidate, max-age=0")
APPEND TO ARRAY:C911($valeur; "-1")
APPEND TO ARRAY:C911($valeur; "*")

WEB SET HTTP HEADER:C660($champ; $valeur)

WEB SEND TEXT:C677($1)