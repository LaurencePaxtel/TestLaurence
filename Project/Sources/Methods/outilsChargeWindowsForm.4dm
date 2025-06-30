//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Rémy Scanu
// Date et heure : 14/09/21, 15:23:32
// ----------------------------------------------------
// Méthode : outilsChargeWindowsForm
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_TEXT:C284($param_t)
C_POINTER:C301($pointeur_p)
C_OBJECT:C1216($position_o)
C_COLLECTION:C1488($collection_c)

ARRAY TEXT:C222($tableau_at; 0)

If (Count parameters:C259>=1)
	$param_t:=$1
Else 
	$param_t:=Get selected menu item parameter:C1005
End if 

$position_o:=New object:C1471("ecartHautEcran"; 30; "ecartBasEcran"; 70)

$collection_c:=Split string:C1554($param_t; ";")
COLLECTION TO ARRAY:C1562($collection_c; $tableau_at)

Case of 
	: (Size of array:C274($tableau_at)=1)  // Chargement d'un formulaire projet
		outilsCreateWindowsForm($tableau_at{1}; ->$position_o)
	: (Size of array:C274($tableau_at)=3)  // Chargement d'un formulaire liste/entrée d'une table avec un objet Form a passé en paramètre si besoin
		$pointeur_p:=Formula from string:C1601("->["+$tableau_at{2}+"]").call()
		
		Case of 
			: ($tableau_at{3}="new") | ($tableau_at{3}="load")
				
				If ($tableau_at{3}="new")
					outilsCreateWindowsForm($tableau_at{1}; ->$position_o; New object:C1471("champ"; New object:C1471); $pointeur_p)
				Else 
					outilsCreateWindowsForm($tableau_at{1}; ->$position_o; New object:C1471("champ"; OB Copy:C1225($2)); $pointeur_p)
				End if 
				
			: ($tableau_at{3}="list")
				$collection_c:=ds:C1482[$tableau_at{2}].all().toCollection()
				
				outilsCreateWindowsForm($tableau_at{1}; ->$position_o; New object:C1471("entitySelection"; $collection_c; "filtre"; New object:C1471); $pointeur_p)
			: ($tableau_at{3}="null")
				outilsCreateWindowsForm($tableau_at{1}; ->$position_o; Null:C1517; $pointeur_p)
		End case 
		
End case 