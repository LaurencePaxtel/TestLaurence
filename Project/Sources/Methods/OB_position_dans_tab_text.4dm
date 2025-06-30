//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier DESCHANELS
// ----------------------------------------------------
// Méthode : OB_position_dans_tab_text
// Description
// 
//
// Paramètres
// ----------------------------------------------------


C_POINTER:C301($1)  //pointeur sur le tableau objet
C_TEXT:C284($2)  // l'attribut ciblé
C_TEXT:C284($3)  // la valeur recherchée
C_LONGINT:C283($0)  // la (première) position trouvée

$array_objet_ptr:=$1

$position_in_array:=0
For ($i; 1; Size of array:C274($array_objet_ptr->); 1)
	$obj:=$array_objet_ptr->{$i}
	$value:=OB Get:C1224($obj; $2; Est un texte:K8:3)
	If ($value=$3)
		$position_in_array:=$i
		$i:=Size of array:C274($array_objet_ptr->)+1
	End if 
End for 
$0:=$position_in_array