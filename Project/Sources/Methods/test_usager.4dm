//%attributes = {}
// Method test_usager  
// 
// 
// #SYNTAX: $L_Erreur:=test_usager(param_1;->param_N) 
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

// #DATE CREATION: 05/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_OBJECT:C1216($O_Usagers; $O_Permanenciers)
$O_Usagers:=JSON Parse:C1218("{}")  // #20170605-2
$O_Permanenciers:=JSON Parse:C1218("{}")  // #20170605-2 à mettre à jour dès 16R3
$O_Usagers:=Usagers_vers_objet
$O_Permanenciers:=Permanenciers_vers_objet