//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 24/09/2020, 08:15:48
// ----------------------------------------------------
// Method: UTL_Table_Field_Get
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)
C_LONGINT:C283($0; $num_table; $num_champ)

$num_table:=Table:C252($1)
$num_champ:=Field:C253($1)

$0:=($num_table*10000)+$num_champ