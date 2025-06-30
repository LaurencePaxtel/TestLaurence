//%attributes = {}
// Method Handle logo client affiche un logo client sur le form d'accueil 
// 
// #SYNTAX: $L_Erreur:=Handle logo client("lire chemin") 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK

// #DATE CREATION: 04/05/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


// Lire le chemin
// Affecter le logo

// #20180504-2

C_LONGINT:C283($L_MyError)
$L_MyError:=1

C_POINTER:C301($P_ObjetlogoClient)
$P_ObjetlogoClient:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "logoClient")

C_TEXT:C284($T_File; $T_Path)
$T_File:="logoClient.jpg"
$T_Path:=Get 4D folder:C485(Dossier Resources courant:K5:16)
If (Test path name:C476($T_Path+$T_File)#Est un document:K24:1)
	
	OBJECT SET VISIBLE:C603($P_ObjetlogoClient->; False:C215)
	
	$L_MyError:=-1
Else 
	
	C_LONGINT:C283($L_Hauteur_objet; $G; $H; $D; $B)
	OBJECT GET COORDINATES:C663(*; "logoClient"; $G; $H; $D; $B)
	$L_Hauteur_objet:=$B-$H
	
	READ PICTURE FILE:C678($T_Path+$T_File; $P_ObjetlogoClient->)
	PICTURE PROPERTIES:C457($P_ObjetlogoClient->; $L_Largeur; $L_Hauteur)
	$R_Rapport:=$L_Hauteur_objet/$L_Hauteur
	
	CREATE THUMBNAIL:C679($P_ObjetlogoClient->; $P_ObjetlogoClient->; ($L_Largeur*$R_Rapport); ($L_Hauteur*$R_Rapport))
	PICTURE PROPERTIES:C457($P_ObjetlogoClient->; $L_Largeur; $L_Hauteur)
	OBJECT SET COORDINATES:C1248(*; "logoClient"; $G-3; $H-3; $G+$L_Largeur+3; $B+3)
	
End if 

$0:=$L_MyError

// EOM




