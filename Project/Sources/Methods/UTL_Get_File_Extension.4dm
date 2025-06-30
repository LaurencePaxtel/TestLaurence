//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 10/09/2020, 09:27:39
// ----------------------------------------------------
// Method: UTL_Get_File_Extension
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($file_name)

ARRAY TEXT:C222($tb_données; 0)

$file_name:=$1
UTL_Cut_Text(->$file_name; ->$tb_données; ".")

$0:="."+$tb_données{Size of array:C274($tb_données)}