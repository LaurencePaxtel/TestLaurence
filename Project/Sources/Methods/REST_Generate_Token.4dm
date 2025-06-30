//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 00:09:50
// ----------------------------------------------------
// Méthode : REST_Generate_Token
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0; $token)
C_TEXT:C284($1; $struc)
$struc:=$1

$token:=UTL_Generate_UID
While (Find in array:C230(<>token_uid; $token)>0)
	$token:=UTL_Generate_UID
End while 
If (Not:C34(Semaphore:C143("MAJ_token"; 600)))
	APPEND TO ARRAY:C911(<>token_uid; $token)
	APPEND TO ARRAY:C911(<>token_uid_Time_stamp; UTL_Generate_TimeStamp)
	APPEND TO ARRAY:C911(<>token_struct; $struc)
	CLEAR SEMAPHORE:C144("MAJ_token")
End if 
$0:=$token