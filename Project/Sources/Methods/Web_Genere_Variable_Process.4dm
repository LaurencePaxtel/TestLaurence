//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 15-04-2019, 08:44:47
// ----------------------------------------------------
// Method: Web_Genere_Variable_Process
// Description
// Cette méthode permet de créer un duplicata d'une variable
// pour le web
//
// Parameters
// $1 : pointeur vers la variable interprocess
// ----------------------------------------------------
var $1 : Pointer

var $table_num; $field_num : Integer
var $pointeur : Pointer

var varName_t : Text
var varLocale_v : Variant

$pointeur:=$1

If (Application type:C494=4D Server:K5:6)
	RESOLVE POINTER:C394($pointeur; varName_t; $table_num; $field_num)
	
	If (varName_t="@<>@")
		varName_t:=Replace string:C233(varName_t; "<>"; "")
		varLocale_v:=Formula from string:C1601("->"+varName_t).call()
		
		Case of 
			: (Type:C295($pointeur->)=18)
				EXECUTE FORMULA:C63("ARRAY TEXT:C222("+varName_t+";0)")
				COPY ARRAY:C226($pointeur->; varLocale_v->)
			: (Type:C295($pointeur->)=Est un entier long:K8:6) | (Type:C295($pointeur->)=Est un entier:K8:5)
				EXECUTE FORMULA:C63("C_LONGINT:C283("+varName_t+")")
				varLocale_v->:=$pointeur->
			: (Type:C295($pointeur->)=6)
				EXECUTE FORMULA:C63("C_BOOLEAN:C305("+varName_t+")")
				varLocale_v->:=$pointeur->
			: (Type:C295($pointeur->)=2)
				EXECUTE FORMULA:C63("C_TEXT:C284("+varName_t+")")
				varLocale_v->:=$pointeur->
		End case 
		
	End if 
	
End if 