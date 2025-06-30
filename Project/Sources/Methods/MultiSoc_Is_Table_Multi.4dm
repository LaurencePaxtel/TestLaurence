//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 25/09/18, 14:56:38
// ----------------------------------------------------
// Méthode : MultiSoc_Is_Table_Multi
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
C_POINTER:C301($table_ptr)
C_BOOLEAN:C305($is_table_multi; $multisoc_table_check)
C_LONGINT:C283($pos)

$table_ptr:=$1
$multisoc_table_check:=True:C214

ARRAY TEXT:C222($tb_multisoc_tables_multi_t; 0)
APPEND TO ARRAY:C911($tb_multisoc_tables_multi_t; Table name:C256(->[TypesTables:11]))
APPEND TO ARRAY:C911($tb_multisoc_tables_multi_t; Table name:C256(->[ReferenceUnique:2]))

If (Count parameters:C259>1)
	$multisoc_table_check:=$2
End if 

If ($multisoc_table_check)
	
	If (Not:C34(Undefined:C82($tb_multisoc_tables_multi_t)))
		$pos:=Find in array:C230($tb_multisoc_tables_multi_t; Table name:C256($table_ptr))
		
		If ($pos>0)
			$is_table_multi:=True:C214
		End if 
		
	End if 
	
End if 

$0:=$is_table_multi