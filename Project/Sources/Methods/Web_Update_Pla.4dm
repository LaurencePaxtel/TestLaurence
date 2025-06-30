//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 08/04/20, 04:13:16
// ----------------------------------------------------
// Method: Web_Update_Pla
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $table)
C_TEXT:C284($2; $libelle; $3; $operation; $Status)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id)

var champID_p : Pointer

$table:=$1
$libelle:=$2
$operation:=$3
$O_Output:=New object:C1471
$continu:=True:C214
$status:="Success"

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table)+"]id")

READ WRITE:C146($table->)

If ($id#0)
	
	QUERY:C277($table->; champID_p->=$id)
	MultiSoc_Filter($table)
	
	If (Records in selection:C76($table->)=1)
		If (Locked:C147($table->))
			$continu:=False:C215
		End if 
	Else 
		$continu:=False:C215
	End if 
	
	
Else 
	
	$continu:=False:C215
	
End if 

If ($continu)
	
	Case of 
		: ($operation="resize")
			
			[Events:103]EVE_Heure_Au:8:=Time:C179(OB Get:C1224($O_Data; "eve_heure_au"; Est un texte:K8:3))
			
		: ($operation="drop")
			
			[Events:103]EVE_Date_Du:5:=Date:C102(OB Get:C1224($O_Data; "eve_date_du"; Est un texte:K8:3))
			[Events:103]EVE_Heure_Du:7:=Time:C179(OB Get:C1224($O_Data; "eve_heure_du"; Est un texte:K8:3))
			[Events:103]EVE_Date_Au:6:=Date:C102(OB Get:C1224($O_Data; "eve_date_au"; Est un texte:K8:3))
			[Events:103]EVE_Heure_Au:8:=Time:C179(OB Get:C1224($O_Data; "eve_heure_au"; Est un texte:K8:3))
			
	End case 
	
	SAVE RECORD:C53($table->)
	
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)

$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)