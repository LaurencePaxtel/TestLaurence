//%attributes = {}
// Method hm_Get_Zoneref retourne la référence de la zone hmCal 
// 
// #SYNTAX: $L_ref:=hm_Get_Zoneref("zone") 
// #PARAMETERS:
//     $0 Long            : Référence de la zone
//     $1 Text            : Nom de la zone

// #DATE CREATION: 06/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_LONGINT:C283($0)

C_TEXT:C284($1; $T_Zone)
$T_Zone:=$1

C_POINTER:C301($P_Zone)
$P_Zone:=OBJECT Get pointer:C1124(Objet nommé:K67:5; $T_Zone)

ASSERT:C1129(Not:C34(Is nil pointer:C315($P_Zone)); "la référence de la zone est impossible")

$0:=$P_Zone->

// EOM