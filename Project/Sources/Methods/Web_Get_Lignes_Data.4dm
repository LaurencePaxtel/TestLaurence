//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 24-12-18, 16:11:12
// ----------------------------------------------------
// Method: Web_Get_Lignes_Data
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_TEXT:C284($JSON)
C_LONGINT:C283($no_table_origin)
C_POINTER:C301($table_piece; $table_lignes; $table_field_origin; $table_field_origin_table)
C_OBJECT:C1216($O_Data)

READ ONLY:C145($2->)

$table_piece:=$1
$table_lignes:=$2
$table_field_origin:=$3

If (Count parameters:C259>3)
	$table_field_origin_table:=$4
End if 

$no_table_origin:=Table:C252($table_piece)

$O_Data:=Web_AGL_Get_Post_Json_Data
$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

If ($id#0)
	
	If (Count parameters:C259>3)
		QUERY:C277($table_lignes->; $table_field_origin->=$id; *)
		QUERY:C277($table_lignes->;  & ; $table_field_origin_table->=$no_table_origin)
	Else 
		QUERY:C277($table_lignes->; $table_field_origin->=$id)
	End if 
	
	MultiSoc_Filter($table_lignes)
Else 
	REDUCE SELECTION:C351($table_lignes->; 0)
End if 

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

$JSON:=Selection to JSON:C1234($table_lignes->; SelectionJson_template($table_lignes))
WEB SEND TEXT:C677($JSON)