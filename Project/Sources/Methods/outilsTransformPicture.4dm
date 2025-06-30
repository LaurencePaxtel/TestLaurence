//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Dev
// Date et heure : 29/03/21, 15:06:43
// ----------------------------------------------------
// Méthode : outilsTransformPicture
// Description
// 
// $1 = Pointeur soit image soit chemin de l'image
// $2 = largeur souhaité
// $3 = hauteur souhaité
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($largeur_el; $hauteur_el; $x_el; $y_el)
C_REAL:C285($coefficient_r; $coefficientDemande_r; $coefficientReduction_r)
C_PICTURE:C286($imageTransform_i)

Case of 
	: (Type:C295($1->)=Est un texte:K8:3)  // Chemin
		READ PICTURE FILE:C678($1->; $imageTransform_i)
	: (Type:C295($1->)=Est une image:K8:10)  // Image
		$imageTransform_i:=$1->
End case 

PICTURE PROPERTIES:C457($imageTransform_i; $largeur_el; $hauteur_el)

$coefficient_r:=$largeur_el/$hauteur_el
$coefficientDemande_r:=$2/$3

If ($coefficient_r>$coefficientDemande_r)  //la largeur sera plus grande.
	$coefficientReduction_r:=$3/$hauteur_el
Else   //la hauteur sera plus grande.
	$coefficientReduction_r:=$2/$largeur_el
End if 

TRANSFORM PICTURE:C988($imageTransform_i; Redimensionnement:K61:2; $coefficientReduction_r; $coefficientReduction_r)
PICTURE PROPERTIES:C457($imageTransform_i; $largeur_el; $hauteur_el)

$x_el:=Choose:C955($largeur_el>$2; Round:C94(($largeur_el-$2)/2; 0); 0)
$y_el:=Choose:C955($hauteur_el>$3; Round:C94(($hauteur_el-$3)/2; 0); 0)

TRANSFORM PICTURE:C988($imageTransform_i; Recadrage:K61:7; $x_el; $y_el; $2; $3)

Case of 
	: (Type:C295($1->)=Est un texte:K8:3)  // Chemin
		WRITE PICTURE FILE:C680($1->; $imageTransform_i)
	: (Type:C295($1->)=Est une image:K8:10)  // Image
		$1->:=$imageTransform_i
End case 