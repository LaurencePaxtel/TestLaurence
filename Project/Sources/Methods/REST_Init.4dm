//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 22/10/18, 07:44:35
// ----------------------------------------------------
// Méthode : REST_Init
// Description
// 
//
// Paramètres
// ----------------------------------------------------

//Initialisation des tableau de sessions actives
ARRAY TEXT:C222(<>token_uid; 0)
ARRAY LONGINT:C221(<>token_uid_Time_stamp; 0)
ARRAY TEXT:C222(<>token_struct; 0)

C_LONGINT:C283(<>nombre_mn_session)
<>nombre_mn_session:=60
