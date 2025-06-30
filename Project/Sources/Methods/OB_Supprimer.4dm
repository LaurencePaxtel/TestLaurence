//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier DESCHANELS
// ----------------------------------------------------
// Méthode : ob_supprimer
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_POINTER:C301($1)
C_TEXT:C284($2; $path)
C_LONGINT:C283($i; $p)
C_OBJECT:C1216($objet; $parent_objet)

$objet:=$1->
$path:=$2

ARRAY OBJECT:C1221($_pile_objet; 0)
ARRAY TEXT:C222($_pile_path; 0)
ARRAY LONGINT:C221($_pile_item; 0)

While (Position:C15("."; $path)>0)
	
	APPEND TO ARRAY:C911($_pile_objet; OB Copy:C1225($objet))
	
	$p:=Position:C15("."; $path)
	$pc:=Position:C15("["; $path)
	
	Case of 
		: ($pc<$p) & ($pc>0)
			$attribut:=Substring:C12($path; 1; $pc-1)
			ARRAY OBJECT:C1221($_objet; 0)
			OB GET ARRAY:C1229($objet; $attribut; $_objet)
			$item:=Substring:C12($path; $pc+1; $p-$pc-2)
			Case of 
				: ($item="?@")
					$pe:=Position:C15("="; $item)
					If ($pe>0)
						$attribut_cible:=Substring:C12($item; 2; $pe-2)
						$valeur_cible:=Substring:C12($item; $pe+1)
						$item_num:=0
						For ($o; 1; Size of array:C274($_objet); 1)
							If (OB_Lire_texte($_objet{$o}; $attribut_cible)=$valeur_cible)
								$item_num:=$o
								$o:=Size of array:C274($_objet)+1
							End if 
						End for 
						$p:=Position:C15("."; $path; $pc)
					Else 
						$item_num:=0
					End if 
				: ($item="F")
					$item_num:=1
				: ($item="L")
					$item_num:=Size of array:C274($_objet)
				Else 
					$item_num:=Num:C11($item)+1  //json commence la numérotation à 0
			End case 
			$path:=Substring:C12($path; $p+1)
			Case of 
				: ($item_num>0) & ($item_num<=Size of array:C274($_objet))
					APPEND TO ARRAY:C911($_pile_path; $attribut)
					APPEND TO ARRAY:C911($_pile_item; $item_num)
					$objet:=$_objet{$item_num}
				Else 
					CLEAR VARIABLE:C89($objet)
			End case 
		: ($p>0)
			$attribut:=Substring:C12($path; 1; $p-1)
			$path:=Substring:C12($path; $p+1)
			APPEND TO ARRAY:C911($_pile_path; $attribut)
			APPEND TO ARRAY:C911($_pile_item; -1)
			$objet:=OB Get:C1224($objet; $attribut; Est un objet:K8:27)
	End case 
End while 

OB REMOVE:C1226($objet; $path)

For ($i; Size of array:C274($_pile_objet); 1; -1)
	$parent_objet:=$_pile_objet{$i}
	$attribut:=$_pile_path{$i}
	$item_num:=$_pile_item{$i}
	If ($item_num=-1)
		OB SET:C1220($parent_objet; $attribut; OB Copy:C1225($objet))
		$objet:=OB Copy:C1225($parent_objet)
	Else 
		ARRAY OBJECT:C1221($_objet; 0)
		OB GET ARRAY:C1229($parent_objet; $attribut; $_objet)
		Case of 
			: ($item_num>0) & ($item_num<=Size of array:C274($_objet))
				$_objet{$item_num}:=OB Copy:C1225($objet)
				OB SET ARRAY:C1227($parent_objet; $attribut; $_objet)
				$objet:=OB Copy:C1225($parent_objet)
			: ($item_num>0)
				ARRAY OBJECT:C1221($_objet; $item_num)
				$_objet{$item_num}:=OB Copy:C1225($objet)
				OB SET ARRAY:C1227($parent_objet; $attribut; $_objet)
				$objet:=OB Copy:C1225($parent_objet)
		End case 
	End if 
End for 

$1->:=$objet