//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier DESCHANELS
// ----------------------------------------------------
// Méthode : OB_Min_entier_long
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_OBJECT:C1216($1; $objet)
C_TEXT:C284($2; $path)

C_LONGINT:C283($0; $min)

C_LONGINT:C283($last_type; $p; $pc)

$objet:=$1
$path:=$2
$pcc:=Position:C15("[]"; $path)
$pcccc:=Position:C15("[["; $path)
$pcpi:=Position:C15("[?"; $path)
$max:=MAXLONG:K35:2

If ($pcc>0) | ($pcccc>0) | ($pcpi>0)
	$last_type:=-1
	While (Position:C15("."; $path)>0)
		$p:=Position:C15("."; $path)
		$pc:=Position:C15("["; $path)
		$pcc:=Position:C15("[]"; $path)
		$pcccc:=Position:C15("[["; $path)
		$pcpi:=Position:C15("[?"; $path)
		Case of 
			: ($pc<$p) & ($pcccc=$pc)
				$attribut:=Substring:C12($path; 1; $pcccc-1)
				$pccccf:=Position:C15("]]"; $path; $pcccc)
				$range:=Substring:C12($path; $pcccc+2; $pccccf-$pcccc-2)
				$sub_path:=Substring:C12($path; $pccccf+3)
				$path:=""
				$pt:=Position:C15("-"; $range)
				ARRAY OBJECT:C1221($_objet; 0)
				OB GET ARRAY:C1229($objet; $attribut; $_objet)
				If ($pt>0)
					Case of 
						: ($pt=1)
							$debut:=1
							$fin:=Num:C11(Substring:C12($range; 2))+1
						: ($pt=Length:C16($range))
							$debut:=Num:C11(Substring:C12($range; 1; Length:C16($range)-1))+1
							$fin:=Size of array:C274($_objet)+1
						Else 
							$debut:=Num:C11(Substring:C12($range; 1; $pt-1))+1
							$fin:=Num:C11(Substring:C12($range; $pt+1))+1
					End case 
				Else 
					$debut:=Num:C11($range)+1
					$fin:=Num:C11($range)+1
				End if 
				If ($fin<Size of array:C274($_objet))
					ARRAY OBJECT:C1221($_objet; $fin)
				End if 
				If ($debut>1)
					DELETE FROM ARRAY:C228($_objet; 1; $debut-1)
				End if 
			: ($pcpi<$p) & ($pcpi=$pc)
				$attribut:=Substring:C12($path; 1; $pcpi-1)
				$pcpif:=Position:C15("]"; $path; $pcpi)
				$query:=Substring:C12($path; $pcpi+2; $pcpif-$pcpi-2)
				$sub_path:=Substring:C12($path; $pcpif+2)
				$path:=""
				ARRAY OBJECT:C1221($_objet_before; 0)
				ARRAY OBJECT:C1221($_objet; 0)
				OB GET ARRAY:C1229($objet; $attribut; $_objet_before)
				$pe:=Position:C15("="; $query)
				If ($pe>0)
					$attribut_cible:=Substring:C12($query; 1; $pe-1)
					$valeur_cible:=Substring:C12($query; $pe+1)
					For ($o; 1; Size of array:C274($_objet_before); 1)
						If (OB_Lire_texte($_objet_before{$o}; $attribut_cible; Est un texte:K8:3)=$valeur_cible)
							APPEND TO ARRAY:C911($_objet; $_objet_before{$o})
						End if 
					End for 
					$p:=Position:C15("."; $path; $pcpif)
				End if 
			: ($pc<$p) & ($pcc=$pc)
				$attribut:=Substring:C12($path; 1; $pcc-1)
				ARRAY OBJECT:C1221($_objet; 0)
				OB GET ARRAY:C1229($objet; $attribut; $_objet)
				$sub_path:=Substring:C12($path; $pcc+3)
				$path:=""
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
	
	For ($i; 1; Size of array:C274($_objet); 1)
		$val:=OB_Lire_entier_long($_objet{$i}; $sub_path)
		If ($val<$min)
			$min:=$val
		End if 
	End for 
End if 

$0:=$min