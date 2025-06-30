//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 11-12-18, 15:39:12
// ----------------------------------------------------
// Method: Web_User_Check_Privilege
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)


/*
Si (Type valeur(<>tb_profils_user_groupes)#Est une variable indéfinie) && (Taille tableau(<>tb_profils_user_groupes)>0)
$pos_el:=Chercher dans tableau(<>tb_profils_user_groupes; $1)
$0:=($pos_el>0)
Fin de si 
*/
$0:=(Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; $1).length#0)