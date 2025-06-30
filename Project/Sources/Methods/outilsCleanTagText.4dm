//%attributes = {}
/*------------------------------------------------------------------------------
Méthode : cwToolCleanTagText
Remplace une chaine de caractère depuis une regex passée en argument.
Un pré-traitement est réalisé pour modifier les balises <br>.

Historique
28/11/22 - Jonathan Fernandez <jonathan@connect-io.fr> - Création
------------------------------------------------------------------------------*/

// Déclarations
var $1 : Text  // Texte source
var $2 : Text  // Expression recherchée [regex]
var $3 : Text  // texte à remplacer
var $0 : Text  // le texte corrigé

var $textRemoveBr_t : Text
var $obsolete_t : Text
var $position_l : Integer
var $pos_trouvee_l : Integer
var $long_trouvée_l : Integer
var $regexValid_b : Boolean

$textRemoveBr_t:=$1

$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "&amp;lt;"; "<")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "&amp;gt;"; ">")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "<br>"; "\r")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "<br/>"; "\r")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "<br>\r"; "\r")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "<br/>\r"; "\r")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "<br/>\r"; "\r")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "<br />"; "\r")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "<br />\r"; "\r")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "<p>"; "")
$textRemoveBr_t:=Replace string:C233($textRemoveBr_t; "</p>"; "")

$source_t:=$textRemoveBr_t
$position_l:=1

// On remplace les sauts de lignes par un espace. (Créer des erreurs sur le regex)
$source_t:=Replace string:C233($source_t; "\r"; "##r")
$source_t:=Replace string:C233($source_t; "\n"; "##n")

If ($2#"")
	
	Repeat 
		$regexValid_b:=Match regex:C1019($2; $source_t; $position_l; $pos_trouvee_l; $long_trouvée_l)
		
		If ($regexValid_b)
			$obsolete_t:=Substring:C12($source_t; $pos_trouvee_l; $long_trouvée_l)
			$source_t:=Replace string:C233($source_t; $obsolete_t; $3)
			
			$position_l:=$pos_trouvee_l+Length:C16($3)
		End if 
		
	Until (Not:C34($regexValid_b))
	
End if 

$source_t:=Replace string:C233($source_t; "##r"; "\r")
$source_t:=Replace string:C233($source_t; "##n"; "\n")

$0:=$source_t