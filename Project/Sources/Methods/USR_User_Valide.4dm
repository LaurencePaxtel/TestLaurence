//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 15/09/18, 04:08:32
// ----------------------------------------------------
// Méthode : USR_User_Valide
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_LONGINT:C283($pos)

ARRAY TEXT:C222($tb_usernames; 0)
ARRAY LONGINT:C221($tb_userIds; 0)

GET USER LIST:C609($tb_usernames; $tb_userIds)
$pos:=Find in array:C230($tb_usernames; $1)

$0:=($pos>0)