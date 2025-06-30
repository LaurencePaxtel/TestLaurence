//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 15/09/18, 03:30:39
// ----------------------------------------------------
// Méthode : USR_Chargement_des_param_USR
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284(<>user_nom_prenom; <>ref_user_initiales; <>usr_current_user)
C_LONGINT:C283(<>ref_user)

<>user_nom_prenom:=[INtervenants:10]IN_NomPrénom:8
<>ref_user:=[INtervenants:10]IN_RéfUser:11
<>ref_user_initiales:=[INtervenants:10]IN_Initiales:7
<>usr_current_user:=Current user:C182