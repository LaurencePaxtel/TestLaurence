//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/11/23, 18:22:29
// ----------------------------------------------------
// Méthode : outilsCSVManage
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Variant
var $3 : Pointer

var $cell_t : Text
var $index_el : Integer
var $init_b : Boolean
var $column_c; $columnB_c : Collection

Case of 
	: ($1=1)  // Séparation du contenu du fichier CSV en tableau de 2 dimensions
		outilsCSVSplitLine($2; $3)
	: ($1=2)  // Après avoir splité le contenu du fichier CSV il faut le remettre dans le bon ordre (Collection de lignes)
		outilsCollectionInit(->$column_c; ->$columnB_c)
		ARRAY TO COLLECTION:C1563($column_c; $2->)
		
		For each ($columnB_c; $column_c)
			
			If ($init_b=True:C214)
				CLEAR VARIABLE:C89($index_el)
			End if 
			
			For each ($cell_t; $columnB_c)
				
				If ($init_b=False:C215)
					$3->push(New collection:C1472)
					$index_el:=$3->length
				Else 
					$index_el:=$index_el+1
				End if 
				
				$3->[$index_el-1].push($cell_t)
			End for each 
			
			If ($init_b=False:C215)
				$init_b:=True:C214
			End if 
			
		End for each 
		
End case 