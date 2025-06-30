//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 30-02-19, 08:47:45
// ----------------------------------------------------
// Method: Web_Get_Ligne_Data
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_TEXT:C284($5)

C_TEXT:C284($data_label; $T_JSON)
C_LONGINT:C283($id)
C_BOOLEAN:C305($continu)
C_POINTER:C301($table; $id_origine; $id_table_origine; $table_origine)
C_OBJECT:C1216($O_Output; $O_Data)

$table:=$1
$id_origine:=$2
$id_table_origine:=$3
$table_origine:=$4
$data_label:=$5

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

READ ONLY:C145($table->)

If ($id#0)
	QUERY:C277($table->; $id_origine->=$id; *)
	QUERY:C277($table->;  & ; $id_table_origine->=Table:C252($table_origine))
	
	If (Records in selection:C76($table->)<=1)
		SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
		
		$T_JSON:=Selection to JSON:C1234($table->; SelectionJson_template($table))
	Else 
		$continu:=False:C215
	End if 
	
Else 
	$continu:=False:C215
End if 

WEB SEND TEXT:C677($T_Json)