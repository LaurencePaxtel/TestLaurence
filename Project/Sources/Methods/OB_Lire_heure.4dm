//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier DESCHANELS
// ----------------------------------------------------
// Méthode : OB_Lire_heure
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_OBJECT:C1216($1; $objet)
C_TEXT:C284($2; $path)

C_TIME:C306($0; $resultat)

C_LONGINT:C283($last_type; $p; $pc)

$objet:=$1
$path:=$2

$last_type:=-1
While (Position:C15("."; $path)>0)
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
			If ($item_num>0) & ($item_num<=Size of array:C274($_objet))
				$objet:=$_objet{$item_num}
			Else 
				CLEAR VARIABLE:C89($objet)
			End if 
		: ($p>0)
			$attribut:=Substring:C12($path; 1; $p-1)
			$path:=Substring:C12($path; $p+1)
			$last_type:=OB Get type:C1230($objet; $attribut)
			Case of 
				: ($last_type=Est un objet:K8:27)
					$objet:=OB Get:C1224($objet; $attribut; Est un objet:K8:27)
				: ($last_type=Est un tableau objet:K8:28)
					ARRAY OBJECT:C1221($_objet; 0)
					OB GET ARRAY:C1229($objet; $attribut; $_objet)
			End case 
	End case 
End while 

$pc:=Position:C15("["; $path)
If ($pc=0)
	$resultat:=OB Get:C1224($objet; $path; Est une heure:K8:8)
Else 
	$attribut:=Substring:C12($path; 1; $pc-1)
	ARRAY TIME:C1223($_val; 0)
	OB GET ARRAY:C1229($objet; $attribut; $_val)
	$item:=Substring:C12($path; $pc+1; Length:C16($path)-$pc-1)
	Case of 
		: ($item="F")
			$item_num:=1
		: ($item="L")
			$item_num:=Size of array:C274($_val)
		Else 
			$item_num:=Num:C11($item)+1  //json commence la numérotation à 0
	End case 
	If ($item_num>0) & ($item_num<=Size of array:C274($_val))
		$resultat:=$_val{$item_num}
	Else 
		$resultat:=?00:00:00?
	End if 
End if 

$0:=$resultat
