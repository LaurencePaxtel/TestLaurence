//%attributes = {}
// Method NewObject_avant_R4 en attendant de pouvoir écrire New object
// 
// 
// #SYNTAX: $O_Objet:=NewObject_avant_R4 
// #PARAMETERS:
//     None
//     $0 Objet           : objet défini

// #DATE CREATION: 21/11/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_OBJECT:C1216($0; $O_Output)
$O_Output:=JSON Parse:C1218("{}")

$0:=$O_Output