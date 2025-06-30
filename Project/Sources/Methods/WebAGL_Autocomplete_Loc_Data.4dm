//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 18-02-19, 08:45:13
// ----------------------------------------------------
// Method: WebAGL_Autocomplete_Loc_Data
// Description
// 
//
// Parameters
// ----------------------------------------------------
var ${1} : Pointer

var $request_term_1; $request_term_2 : Text
var $size; $i; $id_origin : Integer
var $continu : Boolean
var $table; $field_id; $field_value; $field_value_second; $field_id_origin; $option_field; $option_value : Pointer
var $O_Output; $O_Data : Object

var champRef_p : Pointer

ARRAY TEXT:C222($tb_value; 0)
ARRAY TEXT:C222($tb_value_second; 0)

ARRAY LONGINT:C221($tb_id; 0)

ARRAY DATE:C224($tb_value_date_naissance; 0)

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

$id_origin:=Num:C11(OB Get:C1224($O_Data; "id_bien"; Est un texte:K8:3))

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

If ($field_id_origin#Null:C1517)
	ARRAY LONGINT:C221($tb_heberge_id; 0)
	
	QUERY:C277([Locations:84]; [Locations:84]LOC_Bien_ID:5=$id_origin)
	MultiSoc_Filter(->[Locations:84])
	
	SELECTION TO ARRAY:C260([Locations:84]LOC_HB_ID:3; $tb_heberge_id)
	QUERY SELECTION WITH ARRAY:C1050([HeBerge:4]ID:65; $tb_heberge_id)
End if 

If (($option_field#Null:C1517) & ($option_value#Null:C1517))
	QUERY SELECTION:C341($table->; $option_field->=$option_value->)
End if 

MultiSoc_Filter($table)

ORDER BY:C49($table->; $field_value->; >)
$size:=Records in selection:C76($table->)

ARRAY OBJECT:C1221($tb_result; $size)

If ($field_value_second=Null:C1517)
	SELECTION TO ARRAY:C260($field_id->; $tb_id; $field_value->; $tb_value)
	
	For ($i; 1; $size)
		OB SET:C1220($tb_result{$i}; "id"; $tb_id{$i}; "value"; $tb_value{$i})
		
		If ($i=10)
			$i:=$size
		End if 
		
	End for 
	
Else 
	SELECTION TO ARRAY:C260($field_id->; $tb_id; $field_value->; $tb_value; $field_value_second->; $tb_value_second; [HeBerge:4]HB_DateNéLe:5; $tb_value_date_naissance)
	
	For ($i; 1; $size)
		OB SET:C1220($tb_result{$i}; "id"; $tb_id{$i}; "value"; String:C10($tb_value_date_naissance{$i})+" "+$tb_value{$i}+" "+$tb_value_second{$i})
		
		If ($i=10)
			$i:=$size
		End if 
		
	End for 
	
End if 

$JSON:=JSON Stringify array:C1228($tb_result)
WEB SEND TEXT:C677($JSON)