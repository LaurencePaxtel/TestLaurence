//%attributes = {}
// Method Open Quick report opens a Quick Report window 
// 
// #SYNTAX: $L_Erreur:=Open Quick report(->table) 
// #PARAMETERS:
//     $1 Pointer         : table to be displayed

// #DATE CREATION: 20/12/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_POINTER:C301($1; $P_Table)
$P_Table:=$1


SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
//FIRST RECORD($P_Table->)
QR REPORT:C197($P_Table->; Char:C90(1))
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)

// EOM

