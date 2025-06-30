//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 15/09/18, 03:28:33
// ----------------------------------------------------
// Méthode : USR_Identification
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284(The_Login; The_PW)
C_LONGINT:C283(try)

MultiSoc_Init_Variables
DebutDécGroupes

UTL_Fenetre(400; 150; Dialogue modal déplaçable:K34:7; "Accès à votre logiciel")
DIALOG:C40("Login_utilisateur")

USR_Chargement_des_param_USR
CLOSE WINDOW:C154