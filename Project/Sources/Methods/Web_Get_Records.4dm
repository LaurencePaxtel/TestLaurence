//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20/05/27, 08:37:16
// ----------------------------------------------------
// Method: Web_Get_Records
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)

C_TEXT:C284($JSON; $setected)
C_LONGINT:C283($i; $id_selected)
C_POINTER:C301($table_target; $field_target_field_id; $field_target_value; $table_lk; $table_lk_field; $table_lk_field_id)
C_OBJECT:C1216($O_Data)

$table_target:=$1
$field_target_field_id:=$2
$field_target_value:=$3
$table_lk:=$4
$table_lk_field:=$5
$table_lk_field_id:=$6

$O_Data:=Web_AGL_Get_Post_Json_Data
$id_selected:=Num:C11(OB Get:C1224($O_Data; "id_selected"; Est un texte:K8:3))

READ ONLY:C145($table_target->)

ALL RECORDS:C47($table_target->)
MultiSoc_Filter($table_target)

Case of 
	: ($1=->[Immeuble:105])
		ORDER BY:C49([Immeuble:105]; [Immeuble:105]IMM_Nom:3; >)
End case 

READ ONLY:C145($table_lk->)

QUERY:C277($table_lk->; $table_lk_field_id->=$id_selected)
MultiSoc_Filter($table_lk)

ARRAY OBJECT:C1221($tb_object; Records in selection:C76($table_target->))

While (Not:C34(End selection:C36($table_target->)))
	$i:=$i+1
	
	If ($table_lk_field->=$field_target_field_id->)
		$setected:="selected"
	End if 
	
	OB SET:C1220($tb_object{$i}; "id"; String:C10($field_target_field_id->); "value"; $field_target_value->; "status"; $setected)
	
	CLEAR VARIABLE:C89($setected)
	NEXT RECORD:C51($table_target->)
End while 

$JSON:=JSON Stringify array:C1228($tb_object)
WEB SEND TEXT:C677($JSON)