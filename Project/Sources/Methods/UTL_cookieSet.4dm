//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 00:41:04
// ----------------------------------------------------
// Méthode : UTL_cookieSet
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

ARRAY TEXT:C222(web_tabChamps; 0)
ARRAY TEXT:C222(web_tabValeurs; 0)

APPEND TO ARRAY:C911(web_tabChamps; "Proxy-Connection")
APPEND TO ARRAY:C911(web_tabValeurs; "close")

APPEND TO ARRAY:C911(web_tabChamps; "Cache-Control")
APPEND TO ARRAY:C911(web_tabValeurs; "private")

APPEND TO ARRAY:C911(web_tabChamps; "Expires")
APPEND TO ARRAY:C911(web_tabValeurs; "Wed, 23 Aug 2017 00:00:00 GMT")

APPEND TO ARRAY:C911(web_tabChamps; "SET-COOKIE")
APPEND TO ARRAY:C911(web_tabValeurs; "session="+$1+"; path=/; HttpOnly")

APPEND TO ARRAY:C911(web_tabChamps; "Server")
APPEND TO ARRAY:C911(web_tabValeurs; "Microsoft-IIS/8")

WEB SET HTTP HEADER:C660(web_tabChamps; web_tabValeurs)