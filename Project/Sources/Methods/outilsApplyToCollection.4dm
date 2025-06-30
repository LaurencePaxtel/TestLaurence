//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Dev
// Date et heure : 06/05/21, 15:10:15
// ----------------------------------------------------
// Méthode : outilsApplyToCollection
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)  // Collection
C_VARIANT:C1683($2)  // Valeur à appliquer
C_TEXT:C284($3)  // Si $2 = Objet, nom de la propriété [optionnel]

C_VARIANT:C1683($element_v)

For each ($element_v; $1->)
	
	Case of 
		: (Value type:C1509($element_v)=Est un objet:K8:27)
			$element_v[$3]:=$2
	End case 
	
End for each 