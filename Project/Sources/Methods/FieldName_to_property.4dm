//%attributes = {}
// Method FieldName_to_property retourne une chaine   
// 
// #SYNTAX: $T_Suffixe:=FieldName_to_property(->champ) 
// #PARAMETERS:
//     $0 Text            : encodage
//     $2 Pointer         : champ

// #DATE CREATION: 18/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_TEXT:C284($0)
C_POINTER:C301($1)

C_TEXT:C284($T_Name)
C_POINTER:C301($P_Field)

$P_Field:=$1

$T_Name:=Field name:C257($P_Field)
$T_Name:=Replace string:C233($T_Name; "."; "")
$T_Name:=Lowercase:C14(Uppercase:C13($T_Name))

$0:=$T_Name