//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 12/07/23, 17:12:55
// ----------------------------------------------------
// Méthode : outilsCollectionValueToC(o)nt(ent)CSV
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Object
var $2 : Collection

var $result_t; $propriete_t : Text
var $collection_c : Collection

Case of 
	: (Value type:C1509($1.value)=Est un objet:K8:27)
		
		If (Count parameters:C259=2)  // L'ordre d'apparition des champs est imposée
			
			For each ($propriete_t; $2)
				
				If ($1.value[$propriete_t]#Null:C1517)
					
					If (Value type:C1509($1.value[$propriete_t])#Est un objet:K8:27) | (Value type:C1509($1.value[$propriete_t])#Est une collection:K8:32)
						$result_t:=$result_t+String:C10($1.value[$propriete_t])
						
						If ($2.indexOf($1.value[$propriete_t])<($2.length-1))
							$result_t:=$result_t+Char:C90(Tabulation:K15:37)
						End if 
						
					End if 
					
				End if 
				
			End for each 
			
		Else   // Pas de règle
			$collection_c:=OB Entries:C1720($1.value)
			
			For each ($element_o; $collection_c)
				
				If (Value type:C1509($element_o.value)#Est un objet:K8:27) | (Value type:C1509($element_o.value)#Est une collection:K8:32)
					$result_t:=$result_t+String:C10($element_o.value)
					
					If ($collection_c.indexOf($element_o)<($collection_c.length-1))
						$result_t:=$result_t+Char:C90(Tabulation:K15:37)
					End if 
					
				End if 
				
			End for each 
			
		End if 
		
End case 

$1.result:=$result_t