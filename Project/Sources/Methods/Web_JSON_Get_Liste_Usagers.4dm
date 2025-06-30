//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 17-12-18, 18:46:40
// ----------------------------------------------------
// Method: Web_JSON_Get_Liste_Usagers
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($titre)

ARRAY OBJECT:C1221($Object_Result; 0)

ARRAY TEXT:C222($tb_nom; 0)
ARRAY TEXT:C222($tb_prenom; 0)
ARRAY LONGINT:C221($tb_id; 0)

SET QUERY LIMIT:C395(10)
ALL RECORDS:C47([HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])

SELECTION TO ARRAY:C260([HeBerge:4]HB_Nom:3; $tb_nom; *)
SELECTION TO ARRAY:C260([HeBerge:4]HB_Prénom:4; $tb_prenom; *)
SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $tb_id)

C_LONGINT:C283($size)
$size:=Size of array:C274($tb_id)

ARRAY OBJECT:C1221($Object_Result; $size)

C_LONGINT:C283($i)

For ($i; 1; $size)
	OB SET:C1220($Object_Result{$i}; "id"; String:C10($tb_id{$i}))
	OB SET:C1220($Object_Result{$i}; "value"; $tb_nom{$i}+" "+$tb_prenom{$i})
End for 

$titre:="Usagers"

$object:=New object:C1471("title"; $titre; "type"; "radio"; "value"; $titre)

OB SET ARRAY:C1227($object; "list"; $Object_Result)

$JSON:=JSON Stringify:C1217($object)

WEB SEND TEXT:C677($JSON)


