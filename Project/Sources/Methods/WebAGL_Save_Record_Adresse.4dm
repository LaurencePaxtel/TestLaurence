//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 09-01-19, 08:51:35
// ----------------------------------------------------
// Method: WebAGL_Save_Record_Adresse
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($table; $1)
C_TEXT:C284($libelle; $2; $Status)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id; $id_table_origine)

var champID_p : Pointer

$table:=$1
$libelle:=$2
$O_Output:=New object:C1471
$continu:=True:C214
$id_table_origine:=Table:C252($table)

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table)+"]id")

READ WRITE:C146($table->)
READ WRITE:C146([Adresses:53])

If ($id#0)
	
	QUERY:C277($table->; champID_p->=$id)
	
	If (Records in selection:C76($table->)=1)
		If (Locked:C147($table->))
			$continu:=False:C215
		End if 
	Else 
		$continu:=False:C215
	End if 
	
Else 
	CREATE RECORD:C68($table->)
	MultiSoc_Init_Structure($table)
	$id:=champID_p->
End if 

If ($continu)
	
	ARRAY TEXT:C222($tb_restricted; 0)
	APPEND TO ARRAY:C911($tb_restricted; "id")
	
	Web_AGL_Json_To_Record($table; ->$O_Data; ->$tb_restricted)
	
	QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=$id; *)
	QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=$id_table_origine)
	
	Case of 
		: (Records in selection:C76([Adresses:53])=1)
			
			If (Locked:C147([Adresses:53]))
				$continu:=False:C215
			End if 
			
		: (Records in selection:C76([Adresses:53])=0)
			
			CREATE RECORD:C68([Adresses:53])
			MultiSoc_Init_Structure(->[Adresses:53])
			[Adresses:53]AD_ID_Origine:34:=$id
			[Adresses:53]AD_ID_Table_Origine:35:=$id_table_origine
			
		Else 
			$continu:=False:C215
			//error
	End case 
	
	If ($continu)
		
		$O_Data:=OB Get:C1224($O_Data; "adresse"; Est un objet:K8:27)
		$O_Data:=OB Get:C1224($O_Data; "data"; Est un objet:K8:27)
		Web_AGL_Json_To_Record(->[Adresses:53]; ->$O_Data; ->$tb_restricted)
		
		SAVE RECORD:C53($table->)
		SAVE RECORD:C53([Adresses:53])
		
		$status:="Success"
		
	Else 
		$status:="Failed"
	End if 
	
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)