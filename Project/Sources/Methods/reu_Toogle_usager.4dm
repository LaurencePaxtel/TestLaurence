//%attributes = {}
// Method reu_Toogle_usager  
// 
// 
// #SYNTAX: reu_Toogle_usager($L_ID) 
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

// #DATE CREATION: 09/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_LONGINT:C283($1; $L_ID_Usager)
$L_ID_Usager:=$1

C_POINTER:C301($P_LB; $P_Controle)
hm_Get_Pointer_LB_usagers(->$P_LB)
4DLB_Lire_tableau_controle($P_LB; ->$P_Controle)

C_POINTER:C301($P_Usagers_pk)
$P_Usagers_pk:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "pk")

C_LONGINT:C283($L_Pos)
$L_Pos:=Find in array:C230($P_Usagers_pk->; $L_ID_Usager)

If ($P_Controle->{$L_Pos}=0)
	$P_Controle->{$L_Pos}:=lk ligne masquée:K53:31
Else 
	$P_Controle->{$L_Pos}:=0
End if 

// EOM



