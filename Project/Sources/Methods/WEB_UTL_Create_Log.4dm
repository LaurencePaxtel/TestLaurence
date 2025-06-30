//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 25/10/18, 18:04:57
// ----------------------------------------------------
// Méthode : WEB_UTL_Create_Log
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($1; $log_description)

$log_description:=$2

READ WRITE:C146([Web_logs:82])
CREATE RECORD:C68([Web_logs:82])
MultiSoc_Init_Structure(->[Web_logs:82])
[Web_logs:82]Log_Erreur:8:=error
[Web_logs:82]Log_TimeStamp:3:=UTL_genere_timestamp
[Web_logs:82]Log_UID_Utilisateur:2:=w_userUID  //  WARNING : la fiche reste a charger des vérification du token
[Web_logs:82]Log_URL:6:=w_url
[Web_logs:82]Log_Description:4:=$log_description
SAVE RECORD:C53([Web_logs:82])
UNLOAD RECORD:C212([Web_logs:82])
READ ONLY:C145([Web_logs:82])

