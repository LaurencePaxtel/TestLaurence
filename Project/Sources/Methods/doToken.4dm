//%attributes = {}
// Method doToken  
// 
// 
// #SYNTAX: $L_Erreur:=doToken(param_1;->param_N) 
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

// #DATE CREATION: 11/10/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


// on doit être sur un enregsitrement !

C_TEXT:C284($0; $T_Token)

C_DATE:C307($1; $D_Current_date)
$D_Current_date:=$1
C_TIME:C306($2; $H_Current_time)
$H_Current_time:=$2

C_TEXT:C284($T_Current_time)
$T_Current_time:=String:C10($H_Current_time)

ARRAY TEXT:C222($rT_Split; 0)
4DCAR_Split_String(->$rT_Split; ":"; $T_Current_time)


$T_Token:=String:C10(Year of:C25($D_Current_date); "0000")+String:C10(Month of:C24($D_Current_date); "00")+String:C10(Day of:C23($D_Current_date); "00")
$T_Token:=$T_Token+$rT_Split{1}+$rT_Split{2}+$rT_Split{3}
$T_Token:=$T_Token+"-"+Generate UUID:C1066

$0:=$T_Token

// EOM

