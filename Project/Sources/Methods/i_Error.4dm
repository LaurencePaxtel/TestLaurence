//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : i_Error  
//{
//{          Vendredi 5 Jamarsnvier 1999 à 14:56:23
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
var $erreur_o : Object

ARRAY TEXT:C222($composant_at; 0)
ARRAY TEXT:C222($lib_at; 0)

ARRAY LONGINT:C221($code_ai; 0)

GET LAST ERROR STACK:C1015($code_ai; $composant_at; $lib_at)

OB SET:C1220($erreur_o; \
"libelle"; $lib_at{1}; \
"methode"; Error Method; \
"ligne"; Error Line; \
"code"; Error)
TRACE:C157
gError:=Error