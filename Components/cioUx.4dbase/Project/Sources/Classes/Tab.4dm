/*------------------------------------------------------------------------------
Class : cs.Tab

Gére les onglets dans les formulaires

------------------------------------------------------------------------------*/

Class constructor($tabsName_t : Text)
/*------------------------------------------------------------------------------
Fonction : Tab.new
	
Initialisation de la class Tab.
	
Paramètre
$tabName_t -> Nom des onglets dans le formulaire.
	
Historique
18/03/22 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	This:C1470.tabsName_t:=$tabsName_t  // Nom de la dataclasse
	This:C1470.tab_c:=New collection:C1472()
	This:C1470.tab_c.push("")
	
	
	
Function add($fileName_t : Text)
/*------------------------------------------------------------------------------
Fonction : Tab.add()
	
Ajoute un onglet.
	
Paramètre
$fileName_t -> 
	
Historique
18/03/22 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	This:C1470.tab_c.push($fileName_t)
	
	
	
Function tabUpdate($tab_i : Integer)
/*------------------------------------------------------------------------------
Fonction : Tab.tabUpdate()
	
Mise à jour d'un onglet
	
Paramètre
$tab_i -> Numéro de l'onglet à mettre à jour
	
Historique
18/03/22 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	var $color_t : Text
	var $tabFileName_t : Text
	var $file_f : 4D:C1709.File
	var $SVG_t : Text
	
	// On selectionne la couleur
	$color_t:=Choose:C955(FORM Get current page:C276=$tab_i; Storage:C1525.color.secondary; Storage:C1525.color.primary)
	
	// On ouvre le fichier SVG
	$tabFileName_t:=This:C1470.tab_c[$tab_i]
	$file_f:=Folder:C1567(fk resources folder:K87:11).file("fontawesome-svg/"+$tabFileName_t)
	$SVG_t:=SVG_Open_file($file_f.platformPath)
	
	// On charge la couleur
	SVG_SET_FILL_BRUSH($SVG_t; $color_t)
	OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.tabsName_t+String:C10($tab_i))->:=SVG_Export_to_picture($SVG_t; 0)
	SVG_CLEAR($SVG_t)
	
	If (FORM Get current page:C276=$tab_i)
		OBJECT SET RGB COLORS:C628(*; "TabRect"+String:C10($tab_i); "transparent"; "#FFFFFF")
	End if 
	
	
	
Function tabsUpdate()
/*------------------------------------------------------------------------------
Fonction : Tab.tabsUpdate()
	
Mise à jour de toute la barre d'onglet.
	
Historique
18/03/22 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	OBJECT SET RGB COLORS:C628(*; "tabRect@"; "transparent"; "#BBBBBB")
	
	For ($i; 1; (This:C1470.tab_c.length-1))
		This:C1470.tabUpdate($i)
	End for 