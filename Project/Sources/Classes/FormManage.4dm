/*------------------------------------------------------------------------------
Class : cs.FormManage

Class de gestion d'un formulaire

------------------------------------------------------------------------------*/
Class constructor
	
Function centerElementInWindows($objet_c : Collection; $refFenetre_el : Integer)
/*------------------------------------------------------------------------------
Fonction : FormManage.centerElementInWindows
	
Permet de centrer par programmation des objets par rapport à la taille de la fenêtre
	
Paramètre
$objet_c -> Collection qui contient tous les noms d'objet à appliquer la resize
$refFenetre_el -> Référence de la fenêtre où est située la listbox
	
Historique
21/02/22 - Rémy Scanu - Création
------------------------------------------------------------------------------*/
	
	var $gauche_el; $haut_el; $droite_el; $bas_el; $largeur_el : Integer
	
	GET WINDOW RECT:C443($gauche_el; $haut_el; $droite_el; $bas_el; $refFenetre_el)
	$largeur_el:=$droite_el-$gauche_el
	
Function cleanProperty($property_t : Text)->$propertyClean_t : Text
	$propertyClean_t:=Replace string:C233($property_t; Char:C90(Guillemets:K15:41); "")
	
	$propertyClean_t:=Replace string:C233($propertyClean_t; "°"; "")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "'"; "")
	
	$propertyClean_t:=Replace string:C233($propertyClean_t; "à"; "a")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "â"; "a")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "é"; "e")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "è"; "e")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "ê"; "e")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "î"; "i")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "ô"; "o")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "ù"; "u")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "û"; "u")
	
	$propertyClean_t:=Replace string:C233($propertyClean_t; "("; "")
	$propertyClean_t:=Replace string:C233($propertyClean_t; ")"; "")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "?"; "")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "!"; "")
	$propertyClean_t:=Replace string:C233($propertyClean_t; ":"; "")
	$propertyClean_t:=Replace string:C233($propertyClean_t; ";"; "")
	$propertyClean_t:=Replace string:C233($propertyClean_t; ","; "")
	
	$propertyClean_t:=Replace string:C233($propertyClean_t; "-"; "")
	$propertyClean_t:=Replace string:C233($propertyClean_t; "_"; "")
	
	$propertyClean_t:=Replace string:C233($propertyClean_t; "  "; "")
	$propertyClean_t:=Replace string:C233($propertyClean_t; " "; "")
	
Function matchElementWithColumn($fieldFileCSV_c : Collection; $column1_c : Collection)->$matchElement_o : Object
	var $field_t; $fieldFileCSV_t; $propriete_t; $position_t : Text
	var $i_el; $lengthMax_el; $moduloProgress_el : Integer
	var $base_o; $configuration_o : Object
	var $columnLabel_c; $data_c; $fieldNoDisplay_c : Collection
	
	outilsCollectionInit(->$columnLabel_c; ->$data_c; ->$fieldNoDisplay_c)
	
	$base_o:=New object:C1471
	
	// Création des colonnes
	For each ($fieldFileCSV_t; $fieldFileCSV_c)
		$columnLabel_c.push(New object:C1471("titre"; $fieldFileCSV_t; "text-align"; 3))
	End for each 
	
	$columnLabel_c.unshift(New object:C1471("titre"; "Nom du champ"))
	
	// Création des data
	For each ($fieldFileCSV_t; $fieldFileCSV_c)
		$propriete_t:=This:C1470.cleanProperty($fieldFileCSV_t)
		
		$base_o[$propriete_t]:=False:C215
		$base_o[$propriete_t+"PropertyOrigin"]:=$fieldFileCSV_t
		$base_o[$propriete_t+"Index"]:=$fieldFileCSV_c.indexOf($fieldFileCSV_t)
		
		$fieldNoDisplay_c.push($propriete_t+"PropertyOrigin"; $propriete_t+"Index")
	End for each 
	
	$fieldNoDisplay_c.unshift("fieldNoDisplay")
	
	$lengthMax_el:=$column1_c.length
	$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
	
	outilsProgressBar(0; "Initialisation"; True:C214)
	
	For each ($field_t; $column1_c)
		
		If ($i_el%$moduloProgress_el=0)
			outilsProgressBar(($column1_c.indexOf($field_t)+1)/$column1_c.length; "Extraction des données en cours..."; True:C214)
		End if 
		
		$data_c.push(OB Copy:C1225(outilsObjectMerge(New object:C1471("field"; $field_t; "fieldNoDisplay"; $fieldNoDisplay_c); $base_o)))
	End for each 
	
	outilsProgressBar(1; "arrêt")
	
	$configuration_o:=New object:C1471(\
		"column"; $columnLabel_c; \
		"data"; $data_c; \
		"title"; "Information"; \
		"subTitle"; "Dans cette fenêtre vous pourrez faire un matching entre votre fichier CSV et 4D"; \
		"textButtonValidation"; "Faire le matching"; \
		"columnRules"; New object:C1471(\
		"fixedColumn"; New collection:C1472(1); \
		"booleanUniqueByLine"; True:C214; \
		"notEnterable"; True:C214; \
		"event"; New collection:C1472(New object:C1471(\
		"name"; "clic"; \
		"action"; "noCopyCollection"))))
	
	$position_t:="center"
	outilsCreateWindowsForm("FormListeGenerique"; ->$position_t; $configuration_o)
	
	$matchElement_o:=OB Copy:C1225($configuration_o)
	
Function resizeFullWidth($fullWidth_b; $objet_c : Collection)
/*------------------------------------------------------------------------------
Fonction : FormManage.resizeFullWidth
	
Permet de resizer par programmation un ojet pour l'adapter au plein écran ou 
à la taille d'origine de la fenêtre
	
Paramètre
$fullWidth_b -> Booléen qui indique si on est dans le cas d'une resize 
d'un objet pour le plein écran
$objet_c -> Collection qui contient tous les noms d'objet à appliquer la resize
	
Historique
17/02/22 - Rémy Scanu - Création
------------------------------------------------------------------------------*/
	var $objet_t : Text
	var $gauche_el; $haut_el; $droite_el; $bas_el : Integer
	var $pointeur_p : Pointer
	
	For each ($objet_t; $objet_c)
		$pointeur_p:=OBJECT Get pointer:C1124(Objet nommé:K67:5; $objet_t)
		
		If (Is nil pointer:C315($pointeur_p)=False:C215)
			OBJECT GET COORDINATES:C663(*; $objet_t; $gauche_el; $haut_el; $droite_el; $bas_el)
			
			Case of 
				: ($fullWidth_b=True:C214)  // Plein écran
					
					If (Form:C1466.objet[$objet_t]=Null:C1517)  // On stocke si on ne la pas déjà fait les coordonnées par défaut de l'objet
						Form:C1466.objet[$objet_t]:=New object:C1471("gauche"; $gauche_el; "haut"; $haut_el; "droite"; $droite_el; "bas"; $bas_el)
					End if 
					
					$droite_el:=Screen width:C187(*)
				: (Form:C1466.objet[$objet_t]#Null:C1517)  // On restitue les valeurs par défaut des coordonnées de l'objet
					$gauche_el:=Form:C1466.objet[$objet_t].gauche
					$haut_el:=Form:C1466.objet[$objet_t].haut
					$droite_el:=Form:C1466.objet[$objet_t].droite
					$bas_el:=Form:C1466.objet[$objet_t].bas
			End case 
			
			OBJECT SET COORDINATES:C1248(*; $objet_t; $gauche_el; $haut_el; $droite_el; $bas_el)
		End if 
		
	End for each 
	
Function resizeWindows($nbColonne_el : Integer; $refFenetre_el : Integer)
/*------------------------------------------------------------------------------
Fonction : FormManage.resizeWindows
	
Permet de resizer par programmation la fenêtre qui affiche les éléments à anonymiser
	
Paramètre
$nbColonne_el -> Nombre de colonne que la listbox doit contenir
$refFenetre_el -> Référence de la fenêtre où est située la listbox
	
Historique
17/02/22 - Rémy Scanu - Création
------------------------------------------------------------------------------*/
	var $gauche_el; $haut_el; $bas_el; $droite_el; $moitie_el; $largeur_el; $largeurForm_el; $hauteurForm_el; $gaucheCalcul_el; $droiteCalcul_el : Integer
	
	$largeur_el:=Screen width:C187(*)
	
	$droiteCalcul_el:=610+(150*($nbColonne_el-1))
	
	OBJECT GET COORDINATES:C663(*; "List box"; $gauche_el; $haut_el; $droite_el; $bas_el)
	OBJECT SET COORDINATES:C1248(*; "List Box"; $gauche_el; $haut_el; Choose:C955($droiteCalcul_el<=$largeur_el; $droiteCalcul_el; $largeur_el-20))
	
	GET WINDOW RECT:C443($gauche_el; $haut_el; $droite_el; $bas_el; $refFenetre_el)
	FORM GET PROPERTIES:C674("FormListeGenerique"; $largeurForm_el; $hauteurForm_el)
	
	$largeurForm_el:=$largeurForm_el+(150*($nbColonne_el-1))
	
	If ($largeurForm_el>$largeur_el)
		$largeurForm_el:=$largeur_el-20
	End if 
	
	$moitie_el:=$largeurForm_el/2
	$gaucheCalcul_el:=($largeur_el/2)-$moitie_el
	
	If ($gaucheCalcul_el<0)  // La Fenêtre va être plus large que la largeur de l'écran...
		$droiteCalcul_el:=$largeur_el-Abs:C99($gaucheCalcul_el)
	Else 
		$droiteCalcul_el:=($largeur_el/2)+$moitie_el
	End if 
	
	SET WINDOW RECT:C444(Abs:C99($gaucheCalcul_el); $haut_el; $droiteCalcul_el; $bas_el; $refFenetre_el; *)
	LISTBOX SET COLUMN WIDTH:C833(*; "List Box"; 150)