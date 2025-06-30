//%attributes = {}
// Method hm_Get_Pointer_LB_usagers retourne un pointeurs sur la LB usagers du calendrier
//  
// #SYNTAX: $L_Erreur:=hm_Get_Pointer_LB_usagers(param_1;->param_N) 
// #PARAMETERS:
//     $1 Pointer         : 


// #DATE CREATION: 06/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_POINTER:C301($1; $P_Out)
$P_Out:=$1

C_POINTER:C301($P_LB)
$P_LB:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "lb_usagers")  // pourra être passé en paramètre


$P_Out->:=$P_LB

// EOM

