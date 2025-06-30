//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 16/10/19, 20:46:30
// ----------------------------------------------------
// Method: Web_Usager_Pointage_Multiple
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Output; $O_Data)
C_LONGINT:C283($i)
C_TEXT:C284($hegerges_ids; $json)
C_BOOLEAN:C305($continu)

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "pointage"; Est un objet:K8:27)

$hegerges_ids:=OB Get:C1224($O_Data; "hegerges_ids"; Est un texte:K8:3)

ARRAY TEXT:C222($tb_usagers_ids_txt; 0)
UTL_Decoupe_texte(->$hegerges_ids; ->$tb_usagers_ids_txt; ";")

ARRAY LONGINT:C221($tb_usagers_ids; Size of array:C274($tb_usagers_ids_txt))

For ($i; 1; Size of array:C274($tb_usagers_ids_txt))
	$tb_usagers_ids{$i}:=Num:C11($tb_usagers_ids_txt{$i})
End for 

QUERY WITH ARRAY:C644([HeBerge:4]ID:65; $tb_usagers_ids)

Web_HB_Pointage_Multiple


OB SET:C1220($O_Output; "Status"; "Success")
$json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($json)