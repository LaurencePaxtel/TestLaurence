//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 08/06/2020, 15:59:04
// ----------------------------------------------------
// Method: UTL_Field_Name
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($field; $1)
C_TEXT:C284($result; $0)

$field:=$1

$result:=Lowercase:C14(Field name:C257($field))

$0:=$result