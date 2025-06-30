//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 21/07/23, 17:16:14
// ----------------------------------------------------
// Méthode : outilsArrayVisibility
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var ${1} : Variant  // Tableau visibilité ListBox ET Tableau colonne qui indique si on doit masquer ou pas la ligne

var $i_el; $j_el : Integer

If (Mod:C98(Count parameters:C259; 2)=0)
	
	For ($i_el; 1; Count parameters:C259)
		
		If (Value type:C1509(${$i_el+1})=Est un booléen:K8:9)  // On choisit de Tout masquer / Tout voir
			
			For ($j_el; 1; Size of array:C274(${$i_el}->))
				${$i_el}->{$j_el}:=${$i_el+1}
			End for 
			
		Else   // On choisit d'afficher une ligne en fonction d'une valeur
			
			If (Size of array:C274(${$i_el}->)=Size of array:C274(${$i_el+1}->))
				
				For ($j_el; 1; Size of array:C274(${$i_el+1}->))
					
					Case of 
						: (Value type:C1509(${$i_el+1}->{$j_el})=Est un texte:K8:3)
							${$i_el}->{$j_el}:=(${$i_el+1}->{$j_el}="")
						: (Value type:C1509(${$i_el+1}->{$j_el})=Est un numérique:K8:4) | (Value type:C1509(${$i_el+1}->{$j_el})=Est un entier long:K8:6)
							${$i_el}->{$j_el}:=(${$i_el+1}->{$j_el}=0)
					End case 
					
				End for 
				
			End if 
			
		End if 
		
		// On passe à la paire de tableaux suivante
		$i_el:=$i_el+1
	End for 
	
End if 