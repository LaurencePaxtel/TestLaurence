//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 16-04-19, 14:24:26
// ----------------------------------------------------
// Method: Web_Get_Variable_Process
// Description
// Méthode web :
// Cette méthode permet de récupérer à partir
// d'une variable interprocess la variable process correspondante
//
// Parameters
// $1 : Pointeur vers la variable interprocess
// $0 : Pointeur vers la variable process
// ----------------------------------------------------
var $0 : Pointer
var $1 : Pointer

var $table_num; $field_num; $valueType_el : Integer

var varName_t : Text
var result_v : Variant

RESOLVE POINTER:C394($1; varName_t; $table_num; $field_num)

If (varName_t="@<>@")
	varName_t:=Replace string:C233(varName_t; "<>"; "")
	result_v:=Formula from string:C1601("->"+varName_t).call()
	
	// Modifié par : Scanu Rémy (14/02/2023)
	$valueType_el:=Formula from string:C1601("Type valeur:C1509(result_v->)").call()
	
	If ($valueType_el=Est une variable indéfinie:K8:13)
		result_v:=Formula from string:C1601("-><>"+varName_t).call()
	End if 
	
End if 

$0:=result_v