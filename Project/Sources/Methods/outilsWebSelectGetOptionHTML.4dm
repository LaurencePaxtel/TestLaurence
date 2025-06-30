//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 06/03/23, 18:20:43
// ----------------------------------------------------
// Méthode : outilsWebSelectGetOptionHTML
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Text
var $1 : Variant
var $2 : Variant
var $3 : Boolean

var $result_t : Text
var $i_el; $pos_el : Integer
var $table_c : Collection

var $table_es : cs:C1710.TAblesSelection
var $typeTable_es : cs:C1710.TypesTablesSelection

ARRAY TEXT:C222($value_at; 0)

$0:="Sélection d'un élément;;"

Case of 
	: (Value type:C1509($1)=Est un texte:K8:3)
		outilsOrdaSearchSimple(->[TypesTables:11]; ->[TypesTables:11]TT_Libellé:4; $1; ->$typeTable_es)
		
		Case of 
			: ($typeTable_es.length>0)
				$table_es:=outilsOrdaSearch($typeTable_es; "TT_RéférenceID"; "TAbles"; "TB_TT_ID")
				outilsOrdaSearchByRefStctre(->$table_es; Session:C1714.storage.intervenant.Ref_Structure)
				
				$table_c:=$table_es.toCollection("TB_Texte").extract("TB_Texte")
				COLLECTION TO ARRAY:C1562($table_c; $value_at)
		End case 
		
	: (Value type:C1509($1)=Est un pointeur:K8:14)
		COPY ARRAY:C226($1->; $value_at)
	: (Value type:C1509($1)=Est une collection:K8:32)
		COLLECTION TO ARRAY:C1562($1; $value_at)
End case 

If (Count parameters:C259>=2)
	
	If (Value type:C1509($2)#Est un objet:K8:27)
		
		If ($2#"")
			$pos_el:=Find in array:C230($value_at; String:C10($2))
			
			If ($pos_el=-1)
				APPEND TO ARRAY:C911($value_at; String:C10($2))
			End if 
			
		End if 
		
	End if 
	
End if 

SORT ARRAY:C229($value_at; >)

For ($i_el; 1; Size of array:C274($value_at))
	
	// Modifié par : Scanu Rémy (22/03/2023)
	// Rajout d'un 3° paramètre pour pouvoir à l'aide d'une formule transformer à ma guise le "Text" dans <option>Text</option>
	If (Count parameters:C259=3)
		$result_t:=$2.call(Null:C1517; $value_at{$i_el})
		$0:=$0+"|"+$result_t+"_"+$result_t
	Else 
		$0:=$0+"|"+$value_at{$i_el}+"_"+$value_at{$i_el}
	End if 
	
	// Modifié par : Scanu Rémy (17/03/2023)
	// Rajout d'un 2° paramètre pour pré-sélectionné <option> sur lequel on est en train de boucler à l'affichage
	If (Count parameters:C259>=2)
		
		Case of 
			: (Value type:C1509($2)=Est un objet:K8:27)
				
				If ($3=True:C214)
					
					If ($value_at{$i_el}=$result_t)
						$0:=$0+"_s"
					End if 
					
				End if 
				
			: ($value_at{$i_el}=String:C10($2))
				$0:=$0+"_s"
		End case 
		
	End if 
	
End for 