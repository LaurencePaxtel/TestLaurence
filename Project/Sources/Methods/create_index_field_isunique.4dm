//%attributes = {}
// Method create_index_field_isunique  

C_LONGINT:C283($maxTableNumber_l; $currentTable_l)
C_LONGINT:C283($maxFieldCount_l; $currentField_l)
C_LONGINT:C283($dontCare_l)  // For GET FIELD PROPERTIES values that are not used.
C_BOOLEAN:C305($dontCare_f; $isIndexed_f; $isUnique_f)
C_TEXT:C284($tableName_t; $fieldName_t)


$maxTableNumber_l:=Get last table number:C254

For ($currentTable_l; 1; $maxTableNumber_l)
	
	If (Is table number valid:C999($currentTable_l))
		
		$maxFieldCount_l:=Get last field number:C255(Table:C252($currentTable_l))
		For ($currentField_l; 1; $maxFieldCount_l)
			
			If (Is field number valid:C1000($currentTable_l; $currentField_l))
				
				// Note the following line breaks over two lines in text,
				// it is one statement in the method:
				GET FIELD PROPERTIES:C258($currentTable_l; $currentField_l; $dontCare_l; $dontCare_l; $isIndexed_f; $isUnique_f; $dontCare_f)
				
				If (($isUnique_f) & (Not:C34($isIndexed_f)))
					
					$tablePtr:=Table:C252($currentTable_l)
					$fieldPtr:=Field:C253($currentTable_l; $currentField_l)
					$tableName_t:=Table name:C256($tablePtr)
					$fieldName_t:=Field name:C257($fieldPtr)
					$indexName_t:="["+$tableName_t+"]"+$fieldName_t+" indexed for uniqueness (kb#77023)"
					ARRAY POINTER:C280($fieldsArray_p; 1)
					$fieldsArray_p{1}:=$fieldPtr
					CREATE INDEX:C966($tablePtr->; $fieldsArray_p; Index BTree standard:K58:3; $indexName_t; *)
					
				End if 
			End if 
		End for 
	End if 
End for 