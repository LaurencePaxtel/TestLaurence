//%attributes = {}
// Method test_tab_get_login  
// 
// 
// #SYNTAX: $L_Erreur:=test_tab_get_login(param_1;->param_N) 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 04/10/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_TEXT:C284($T_User; $T_PW; $T_Token; $T_Message; $T_niveau_user)

$T_User:="Admin1"
$T_PW:="85158515"
$T_niveau_user:="1"
$T_Token:=""

// On veut créer un user dont le username est absolument unique
$L_Erreur:=Handle_user("user_create"; $T_User; $T_PW; $T_niveau_user; ->$T_Token; ->$T_Message)
For ($i; 1; 2)
	
	
	// On veut fournir un token à un utilisateur déjà créé
	$L_Erreur:=Handle_user("user_set_token"; $T_User; $T_PW; $T_niveau_user; ->$T_Token; ->$T_Message)
	
	
End for 

