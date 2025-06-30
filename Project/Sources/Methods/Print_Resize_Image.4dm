//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 03/10/2020, 08:08:30
// ----------------------------------------------------
// Method: Print_Resize_Image
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer

var $position_taquet; $largeur; $hauteur; $img_width; $img_height; $img_offset_h; $img_offset_v; \
$img_mode; $horizontal_move; $vertical_move; $horizontal_size; $vertical_size; $optimal_width; \
$width; $max_width; $max_height; $scale_percent; $width_percent; $height_percent : Real
var $resized; $param_resize_width : Boolean
var $designation : Pointer

$designation:=$1
$param_resize_width:=True:C214
$max_width:=200
$max_height:=0

If (Count parameters:C259>1)
	$max_width:=$2
End if 

If (Count parameters:C259>2)
	$max_height:=$3
End if 

PICTURE PROPERTIES:C457($designation->; $img_width; $img_height; $img_offset_h; $img_offset_v; $img_mode)

OBJECT GET COORDINATES:C663($designation->; $left; $top; $right; $bottom)
$largeur_actuelle_fixe:=$right-$left
$haut_prec:=$bottom-$top

OBJECT GET BEST SIZE:C717($designation->; $largeur; $hauteur; $largeur_actuelle_fixe)

If ($max_width=0)
	$max_width:=$largeur
End if 

If ($max_height=0)
	$max_height:=$hauteur
End if 

$width:=$img_width
$height:=$img_height

$width_percent:=$max_width/$width
$height_percent:=$max_height/$height

If ($width_percent>$height_percent)
	$scale_percent:=$height_percent
Else 
	$scale_percent:=$width_percent
End if 

$optimal_width:=$width*$scale_percent
$height:=$height*$scale_percent

//**************************************************//

$horizontal_move:=$left
$vertical_move:=$top

$horizontal_size:=$optimal_width
$vertical_size:=$height

$deplacement:=$vertical_size-$top
$position_taquet:=Get print marker:C708(Entête formulaire:K43:3)
$position_taquet:=$position_taquet+$deplacement

OBJECT MOVE:C664($designation->; $horizontal_move; $vertical_move; $horizontal_size; $vertical_size; *)

SET PRINT MARKER:C709(Entête formulaire:K43:3; $position_taquet; *)

taille_taquet_base:=Get print marker:C708(taquet)

If ($deplacement>0)
	$resized:=True:C214
End if 

$0:=$resized