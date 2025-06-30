//%attributes = {}
// ----------------------------------------------------
// Développeur (OS) : Kevin
// Date et heure : 27/08/18, 16:55:58
// ----------------------------------------------------
// Méthode : UTL_fenetre

// Paramètres
// $1 largeur de la fenetre
// $2 hauteur de la fenetre
// $3 type de la fenetre
// $4 titre de la fenetre
// $5 Procédure de fermeture de la fenetre
// $6 vrai si resizable
// $7 alignement
// $8 offset vertical
// $9 offset horizontal
// ----------------------------------------------------

C_TEXT:C284(<>data)
$param:=Count parameters:C259

If ($param>1)
	$largeur:=$1
	$hauteur:=$2
	
	If ($param>2)
		$type:=$3
	Else 
		$type:=4
	End if 
	
	If ($param>3)
		$titre:=$4
	Else 
		$titre:=""
	End if 
	
	If ($param>4)
		$procédure_de_fermeture:=$5
	Else 
		$procédure_de_fermeture:=""
	End if 
	
	If ($param>5)
		$resizable:=$6
	Else 
		$resizable:=False:C215
	End if 
	
	If ($param>6)
		$alignement:=$7
	Else 
		$alignement:=""
	End if 
	
	If ($param>7)
		$offset_horizontal:=$8
	Else 
		$offset_horizontal:=0
	End if 
	
	If ($param>8)
		$offset_vertical:=$9
	Else 
		$offset_vertical:=0
	End if 
	
	$haut_perdu:=Menu bar height:C440
	
	If ($resizable=True:C214)
		$type:=$type+4
	End if 
	
	If (($type=4) | ($type=8) | ($type=0) | ($type=5) | ($type=9))
		$haut_perdu:=$haut_perdu+15
	End if 
	
	//`Gestion de 2 écrans
	If (Screen width:C187>2400)
		$centre_horizontal:=Screen width:C187/4
	Else 
		$centre_horizontal:=Screen width:C187/2
	End if 
	$centre_vertical:=((Screen height:C188-$haut_perdu)/2)+$haut_perdu
	
	$haut:=$centre_vertical-($hauteur/2)
	$bas:=$haut+$hauteur
	$gauche:=$centre_horizontal-($largeur/2)
	$droite:=$gauche+$largeur
	
	Case of 
		: (Position:C15("H"; $alignement)#0)
			$haut:=$haut_perdu+10
			$bas:=$haut+$hauteur
			
		: (Position:C15("B"; $alignement)#0)
			$bas:=Screen height:C188-10
			$haut:=$bas-$hauteur
	End case 
	
	Case of 
		: (Position:C15("G"; $alignement)#0)
			$gauche:=10
			$droite:=$gauche+$largeur
			
		: (Position:C15("D"; $alignement)#0)
			$droite:=Screen width:C187-10
			$gauche:=$droite-$largeur
	End case 
	
	If ($offset_horizontal#0)
		$gauche:=$gauche+$offset_horizontal
		$droite:=$droite+$offset_horizontal
	End if 
	
	If ($offset_vertical#0)
		$bas:=$bas+$offset_vertical
		$haut:=$haut+$offset_vertical
	End if 
	
	$titre:=$titre+<>data
	$0:=Open window:C153($gauche; $haut; $droite; $bas; $type; $titre; $procédure_de_fermeture)
Else 
	ALERT:C41("Vous devez passer au moin 2 paramètres à la procédure UTL_Fenêtre")
End if 