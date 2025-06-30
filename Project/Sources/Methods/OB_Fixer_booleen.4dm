//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier DESCHANELS
// ----------------------------------------------------
// Méthode : OB_Fixer_booleen
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_POINTER:C301($1)
C_TEXT:C284($2; $path)
C_BOOLEAN:C305($3; $value)

C_LONGINT:C283($i; $p)
C_OBJECT:C1216($objet; $parent_objet)

$objet:=$1->
$path:=$2
$value:=$3

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
				: ($item="F")
					$item_num:=1
				: ($item="L")
					$item_num:=Size of array:C274($_objet)
				: ($item="N")
					$item_num:=Size of array:C274($_objet)+1
				Else 
					$item_num:=Num:C11($item)+1  //json commence la numérotation à 0
			End case 
			$path:=Substring:C12($path; $p+1)
			Case of 
				: ($item_num>0) & ($item_num<=Size of array:C274($_objet))
					APPEND TO ARRAY:C911($_pile_path; $attribut)
					APPEND TO ARRAY:C911($_pile_item; $item_num)
					$objet:=$_objet{$item_num}
				: ($item_num>0)
					APPEND TO ARRAY:C911($_pile_path; $attribut)
					APPEND TO ARRAY:C911($_pile_item; $item_num)
					CLEAR VARIABLE:C89($objet)
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

$pc:=Position:C15("["; $path)
If ($pc=0)
	OB SET:C1220($objet; $path; $value)
Else 
	ARRAY BOOLEAN:C223($_val; 0)
	$item:=Substring:C12($path; $pc+1; Length:C16($path)-$pc-1)
	$path:=Substring:C12($path; 1; $pc-1)
	OB GET ARRAY:C1229($objet; $path; $_val)
	Case of 
		: ($item="F")
			$item_num:=1
		: ($item="L")
			$item_num:=Size of array:C274($_val)
		: ($item="N")
			$item_num:=Size of array:C274($_val)+1
		Else 
			$item_num:=Num:C11($item)+1  //json commence la numérotation à 0
	End case 
	Case of 
		: ($item_num>0) & ($item_num<=Size of array:C274($_val))
			$_val{$item_num}:=$value
			OB SET ARRAY:C1227($objet; $path; $_val)
		: ($item_num>0)
			ARRAY BOOLEAN:C223($_val; $item_num)
			$_val{$item_num}:=$value
			OB SET ARRAY:C1227($objet; $path; $_val)
	End case 
End if 


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