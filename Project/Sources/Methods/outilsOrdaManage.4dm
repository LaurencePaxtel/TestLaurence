//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 06/09/23, 14:13:37
// ----------------------------------------------------
// Méthode : outilsOrdaManage
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Variant
var $3 : Variant
var $4 : Variant

var $table_t : Text
var $i_el : Integer
var $dataClass_o; $entitySelectionOrder_es; $entity_e : Object

Case of 
	: ($1=1)  // Insérer une entité dans une entité sélection à un positionnement précis
		$dataClass_o:=$2->getDataClass()
		$entitySelectionOrder_es:=ds:C1482[$dataClass_o.getInfo().name].newSelection(dk keep ordered:K85:11)
		
		$table_t:=$3.getDataClass().getInfo().name
		
		If ($table_t=$dataClass_o.getInfo().name)  // L'entité $3 qu'on veut insérer dans l'entitySelection $2 ont la même DataClass
			
			If ($3.indexOf($2->)=-1)  // L'entité $3 n'appartient pas déjà à l'entitySelection $2
				
				If ($4#-1)  // On ne souhaite pas insérer l'entité en dernière position
					
					For each ($entity_e; $2->)
						
						If ($i_el=$4)
							$entitySelectionOrder_es.add($3)
						End if 
						
						$entitySelectionOrder_es.add($entity_e)
						$i_el:=$i_el+1
					End for each 
					
				Else 
					$entitySelectionOrder_es:=$2->copy()
					$entitySelectionOrder_es.add($3)
				End if 
				
				If ($3.indexOf($entitySelectionOrder_es)=-1)  // L'entité $3 n'appartient toujours pas à l'entitySelection $2, on la rajoute à la fin
					$entitySelectionOrder_es.add($3)
				End if 
				
				$2->:=$entitySelectionOrder_es.copy()
				$2->refresh()
			End if 
			
		End if 
		
	: ($1=10)  // Insérer une entité dans une entité sélection à un positionnement précis (Autre méthode)
		$entitySelectionOrder_es:=$2->getDataClass().newSelection(dk keep ordered:K85:11)
		
		If ($4#-1)  // On ne souhaite pas insérer l'entité en dernière position
			$entitySelectionOrder_es.add($2->slice(0; $4))
			$entitySelectionOrder_es.add($3)
			$entitySelectionOrder_es.add($2->slice($4))
		Else 
			$entitySelectionOrder_es:=$2->copy()
			$entitySelectionOrder_es.add($3)
		End if 
		
		$2->:=$entitySelectionOrder_es.copy()
		$2->refresh()
End case 