//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 24-05-19, 08:45:25
// ----------------------------------------------------
// Method: Web_UTL_Record_To_JSON
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($0)
C_POINTER:C301($1)

C_POINTER:C301($table)
C_LONGINT:C283($i; $table_num)
C_OBJECT:C1216($result)

$table:=$1
$table_num:=Table:C252($table)

For ($i; 1; Get last field number:C255($table))
	
	If (Is field number valid:C1000($table; $i))
		C_POINTER:C301($p_nil)
		
		Case of 
			: (Type:C295((Field:C253($table_num; $i))->)=Est une image:K8:10)
				OB SET:C1220($result; FieldName_to_property(Field:C253($table_num; $i)); $p_nil)
			: (Type:C295((Field:C253($table_num; $i))->)=Est un BLOB:K8:12)
				OB SET:C1220($result; FieldName_to_property(Field:C253($table_num; $i)); $p_nil)
			: (Type:C295((Field:C253($table_num; $i))->)=Est une date:K8:7)
				OB SET:C1220($result; FieldName_to_property(Field:C253($table_num; $i)); String:C10((Field:C253($table_num; $i))->))
			: (Type:C295((Field:C253($table_num; $i))->)=Est une heure:K8:8)
				OB SET:C1220($result; FieldName_to_property(Field:C253($table_num; $i)); String:C10((Field:C253($table_num; $i))->))
			Else 
				OB SET:C1220($result; FieldName_to_property(Field:C253($table_num; $i)); (Field:C253($table_num; $i)))
		End case 
		
	End if 
	
End for 

$0:=$result