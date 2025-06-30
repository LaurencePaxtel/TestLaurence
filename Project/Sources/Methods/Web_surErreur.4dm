//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 03:23:23
// ----------------------------------------------------
// Méthode : Web_surErreur
// Description
// Error-handling method
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284(w_userIp)
var $Ref_Structure_t : Text

READ WRITE:C146([Web_logs:82])

If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
End if 


CREATE RECORD:C68([Web_logs:82])
[Web_logs:82]Ref_Structure:9:=$Ref_Structure_t
[Web_logs:82]Log_Erreur:8:=error
[Web_logs:82]Log_TimeStamp:3:=UTL_genere_timestamp
[Web_logs:82]Log_UID_Utilisateur:2:=w_userUID  //  WARNING : la fiche reste a charger des vérification du token
[Web_logs:82]Log_URL:6:=w_url
[Web_logs:82]Log_Adresse_IP:5:=w_userIp
SAVE RECORD:C53([Web_logs:82])

UNLOAD RECORD:C212([Web_logs:82])
READ ONLY:C145([Web_logs:82])