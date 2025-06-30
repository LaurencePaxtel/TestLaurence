//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 11-02-19, 06:05:03
// ----------------------------------------------------
// Method: Web_Save_Table_LK
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_TEXT:C284($5)

C_TEXT:C284($libelle; $Status)
C_LONGINT:C283($id; $id_piece; $id_table_origine)
C_BOOLEAN:C305($continu)
C_POINTER:C301($table_piece; $table_lk; $champ_origin; $champ_origin_lk)
C_OBJECT:C1216($O_Output; $O_Data)

var champID_p : Pointer

$table_piece:=$1
$table_lk:=$2
$champ_origin:=$3
$champ_origin_lk:=$4
$libelle:=$5

$O_Output:=New object:C1471
$continu:=True:C214
$id_table_origine:=Table:C252($table_piece)

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id_piece:=Num:C11(OB Get:C1224($O_Data; "id_piece"; Est un texte:K8:3))
$id_origin_lk:=Num:C11(OB Get:C1224($O_Data; "id_origin_lk"; Est un texte:K8:3))

EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table_lk)+"]id")

READ WRITE:C146($table_lk->)

If (($id_piece#0) & ($id_origin_lk#0))
	QUERY:C277($table_lk->; $champ_origin->=$id_piece; *)
	QUERY:C277($table_lk->;  & ; $champ_origin_lk->=$id_origin_lk)
	
	If (Records in selection:C76($table_lk->)=1)
		
		If (Locked:C147($table_lk->))
			$continu:=False:C215
		End if 
		
	Else 
		CREATE RECORD:C68($table_lk->)
		MultiSoc_Init_Structure($table_lk)
		
		$id:=champID_p->
		$champ_origin->:=$id_piece
		$champ_origin_lk->:=$id_origin_lk
	End if 
	
Else 
	$status:="Failed"
	$continu:=False:C215
End if 

If ($continu)
	SAVE RECORD:C53($table_lk->)
	
	$status:="success"
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "status"; $status)
OB SET:C1220($O_Output; "id"; String:C10($id))

$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)