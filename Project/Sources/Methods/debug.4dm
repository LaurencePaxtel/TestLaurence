//%attributes = {}
// Method debug  
// 
// 
// #SYNTAX: $L_Erreur:=debug(param_1;->param_N) 
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

// #DATE CREATION: 20/05/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


//TRACE

C_DATE:C307($1; $D_Date)  //Date
$D_Date:=$1

C_LONGINT:C283($2; $L_Long)  //Entier long
$L_Long:=$2

C_TEXT:C284($0)

$0:=String:C10(\
Year of:C25($D_Date); "0000")\
+String:C10(Month of:C24($D_Date); "00")\
+String:C10(Day of:C23($D_Date); "00")+"/"\
+String:C10($L_Long; "0000000000")