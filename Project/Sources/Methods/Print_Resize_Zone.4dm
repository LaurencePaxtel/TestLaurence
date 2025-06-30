//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 13/03/20, 14:48:33
// ----------------------------------------------------
// Method: Print_Resize_Zone
// Description
// Redimensionnement automatique de 
// la zone d'impression
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $designation)
C_LONGINT:C283($largeur; $hauteur)
C_BOOLEAN:C305($resized)

$designation:=$1
$resized:=False:C215

OBJECT GET COORDINATES:C663($designation->; $g; $h; $d; $b)
$largeur_actuelle_fixe:=$d-$g
$haut_prec:=$b-$h

OBJECT GET BEST SIZE:C717($designation->; $largeur; $hauteur; $largeur_actuelle_fixe)

$hauteur:=$hauteur
$deplacement:=$hauteur-$haut_prec
$position_taquet_corps:=Get print marker:C708(Corps formulaire:K43:1)
$position_taquet_corps:=$position_taquet_corps+$deplacement

OBJECT MOVE:C664($designation->; $g; $h; $d; $hauteur+$h; *)
OBJECT MOVE:C664(*; "Sep_Vertical@"; 0; 0; 0; $deplacement)

//OBJECT MOVE(*;"Line_Sep_Detail@";0;$deplacement;0;0)


SET PRINT MARKER:C709(Corps formulaire:K43:1; $position_taquet_corps; *)

taille_taquet_base:=Get print marker:C708(taquet)

If ($deplacement>0)
	$resized:=True:C214
End if 

$0:=$resized