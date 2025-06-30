//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 15/02/22, 15:03:41
// ----------------------------------------------------
// Méthode : outilsOrdaExtractSingleField
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_OBJECT:C1216($0)  // EntitySelection avec enregistrements uniques de $1
C_TEXT:C284($1)  // Nom du champ
C_OBJECT:C1216($2)  // EntitySelection

C_TEXT:C284($table_t)
C_VARIANT:C1683($element_v)
C_OBJECT:C1216($table_o)
C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

If ($2.length>0)
	$table_t:=$2[0].getDataClass().getInfo().name
	$0:=ds:C1482[$table_t].newSelection()
	
	If ($2[0][$1]#Null:C1517)
		$collection_c:=$2.distinct($1)
		
		For each ($element_v; $collection_c)
			$table_o:=$2.query($1+" = :1"; $element_v)
			
			If ($table_o.length>0)
				$0.add($table_o[0])
			End if 
			
		End for each 
		
	End if 
	
End if 