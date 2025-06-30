//%attributes = {}
// Method Handle couleurs accueil gère la saisie ou l'affichage de la couleur des bloc d'accueil 
// 
// #SYNTAX: Handle couleurs accueil(selecteur) 
// #PARAMETERS:
//     $1 Long            : selecteur

// #DATE CREATION: 04/05/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_LONGINT:C283($1; $L_Selecteur)
$L_Selecteur:=$1

Case of 
	: ($L_Selecteur=Sur appel extérieur:K2:11) | ($L_Selecteur=Sur chargement:K2:1)
		
		OBJECT SET RGB COLORS:C628(*; "Cadre_DepartHaut"; Coul premier plan:K23:1; <>vl_T_ColorCadreH)  // #20180504-5 
		OBJECT SET RGB COLORS:C628(*; "Cadre_DepartCentre"; Coul premier plan:K23:1; <>vl_T_ColorCadreC)  // #20180504-5 
		OBJECT SET RGB COLORS:C628(*; "Cadre_DepartBas"; Coul premier plan:K23:1; <>vl_T_ColorCadreB)  // #20180504-5 
		
	: ($L_Selecteur=Sur clic:K2:4)
		
		C_POINTER:C301($P_Haut; $P_Centre; $P_Bas)
		$P_Haut:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Button_color_H")
		$P_Centre:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Button_color_C")
		$P_Bas:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Button_color_B")
		
		C_POINTER:C301($P_Current)
		$P_Current:=OBJECT Get pointer:C1124
		
		
		C_POINTER:C301($P_Field)
		$P_Field:=Null:C1517
		Case of 
			: ($P_Current=$P_Haut)
				$P_Field:=->[SOciete:18]SO_CouleurCadreH:14
			: ($P_Current=$P_Centre)
				$P_Field:=->[SOciete:18]SO_CouleurCadreC:15
			: ($P_Current=$P_Bas)
				$P_Field:=->[SOciete:18]SO_CouleurCadreB:16
			Else 
				ALERT:C41("Mauvais sélecteur")
		End case 
		
		If (Macintosh option down:C545) | (Windows Alt down:C563)
			$P_Field->:=0
		Else 
			$P_Field->:=Select RGB color:C956
		End if 
		
End case 

// EOM

