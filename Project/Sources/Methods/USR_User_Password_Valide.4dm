//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 24/10/18, 07:35:21
// ----------------------------------------------------
// Méthode : USR_User_Password_Valide
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($login; $password)
C_LONGINT:C283($pos)
C_BOOLEAN:C305($resultat)

ARRAY TEXT:C222($tb_usernames; 0)
ARRAY LONGINT:C221($tb_userIds; 0)

$login:=$1
$password:=$2

GET USER LIST:C609($tb_usernames; $tb_userIds)
$pos:=Find in array:C230($tb_usernames; $login)

If ($pos>0)
	$resultat:=Validate password:C638($tb_userIds{$pos}; $password)
End if 

$0:=$resultat