//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25-02-19, 10:23:15
// ----------------------------------------------------
// Method: Web_Autocomplete_Charges
// Description
// 
//
// Parameters
// ----------------------------------------------------
var ${1} : Pointer

var $request_term_1; $request_term_2 : Text
var $size; $id_bien; $id_locataire : Integer
var $continu : Boolean
var $table; $field_id; $field_value; $field_value_second; $field_id_origin; $option_field; $option_value : Pointer
var $O_Output; $O_Data : Object

var champRef_p : Pointer

ARRAY TEXT:C222($tb_value; 0)

ARRAY LONGINT:C221($tb_id; 0)
ARRAY LONGINT:C221($tb_id_loc; 0)

$table:=$1
$field_id:=$2
$field_value:=$3

$field_value_second:=Null:C1517
$field_id_origin:=Null:C1517
$option_field:=Null:C1517
$option_value:=Null:C1517

If (Count parameters:C259>3)
	$field_value_second:=$4
End if 

If (Count parameters:C259>4)
	$field_id_origin:=$5
End if 

If (Count parameters:C259>5)
	$option_field:=$6
	$option_value:=$7
End if 

EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]Ref_Structure")

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data

$request_term_1:=OB Get:C1224($O_Data; "data_first"; Est un texte:K8:3)
$request_term_2:=OB Get:C1224($O_Data; "data_second"; Est un texte:K8:3)

$id_bien:=Num:C11(OB Get:C1224($O_Data; "id_bien"; Est un texte:K8:3))
$id_locataire:=Num:C11(OB Get:C1224($O_Data; "id_locataire"; Est un texte:K8:3))

READ ONLY:C145($table->)

If ($request_term_1#"")
	QUERY:C277($table->; $field_value->="@"+$request_term_1+"@"; *)
	
	If ($field_value_second#Null:C1517)
		QUERY:C277($table->;  & ; $field_value_second->="@"+$request_term_2+"@"; *)
	End if 
	
	QUERY:C277($table->;  & ; champRef_p->=Session:C1714.storage.intervenant.Ref_Structure)
	
Else 
	
	If (Count parameters:C259>5)
		QUERY:C277($table->; champRef_p->=Session:C1714.storage.intervenant.Ref_Structure)
	Else 
		QUERY:C277($table->; $field_value->#""; *)
		QUERY:C277($table->;  & ; champRef_p->=Session:C1714.storage.intervenant.Ref_Structure)
	End if 
	
End if 

If ($option_field#Null:C1517) & ($option_value#Null:C1517)
	QUERY SELECTION:C341($table->; $option_field->=$option_value->)
End if 

QUERY:C277([Locations:84]; [Locations:84]LOC_HB_ID:3=$id_locataire)
MultiSoc_Filter(->[Locations:84])

SELECTION TO ARRAY:C260([Locations:84]ID:1; $tb_id_loc)

QUERY SELECTION WITH ARRAY:C1050([Charges:92]CHA_Origine_ID:6; $tb_id_loc)
QUERY SELECTION:C341([Charges:92]; [Charges:92]CHA_Origine_Table_No:8=Table:C252(->[Locations:84]))

MultiSoc_Filter($table)

$size:=Records in selection:C76($table->)
ARRAY OBJECT:C1221($tb_result; $size)

SELECTION TO ARRAY:C260($field_id->; $tb_id; $field_value->; $tb_value)

For ($i; 1; $size)
	QUERY:C277([Charges:92]; [Charges:92]ID:1=$tb_id{$i})
	OB SET:C1220($tb_result{$i}; "id"; $tb_id{$i}; "value"; $tb_value{$i}; "quantite"; "1"; "prix_unitaire"; String:C10([Charges:92]CHA_Montant:5))
	
	If ($i=10)
		$i:=$size
	End if 
	
End for 

$JSON:=JSON Stringify array:C1228($tb_result)
WEB SEND TEXT:C677($JSON)