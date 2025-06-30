//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : i_Fenêtre  N°
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//PARAMETRES :
//$Fen_Offset;$Fen_Left;$Fen_Top;$Fen_Right;$Fen_Bottom;$1;$2;$3;$5 : ENTIER
//$4 : Alpha(255)
//$Fen_Offset : position suivant $3 /Fenetre avec barre de titre
//$Fen_Left : Gauche
//$Fen_Top  : Haut
//$Fen_Right : Droite
//$Fen_Bottom : Bas
//$1 : Largeur de la fenetre
//$2 : Hauteur
//$3 : Type de fenetre
//$4 : titre de la fenetre
//$5 : Cas dans cette procedure = position à l'affichage
//$6 : Si > "" alors Procédure de fermeture de la fenêtre
//{==================================================}
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_LONGINT:C283($5)
C_TEXT:C284($6)

C_LONGINT:C283($Fen_Offset; $Fen_Left; $Fen_Top; $Fen_Right; $Fen_Bottom)

If ($3=0) | ($3=4) | ($3=8) | ($3=16) | ($3=5)
	$Fen_Offset:=10
End if 

Case of 
	: ($5=1)  //Fenêtre standard    
		$Fen_Left:=3
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=33+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=2)  //Fenêtre centrée
		$Fen_Left:=(<>vl_EcranL/2)-($1/2)
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=((<>vl_EcranH-$2)/2)+15+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=3)  //Fenêtre centrée 50 pixel du haut
		$Fen_Left:=(<>vl_EcranL/2)-($1/2)
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=50+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=4)  //Fenêtre centrée 110 pixel du haut
		$Fen_Left:=(<>vl_EcranL/2)-($1/2)
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=110+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=3)  //Fenêtre haut gauche écran
		$Fen_Left:=8
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=39+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=4)  //Fenêtre haut gauche écran type Palette
		$Fen_Left:=3
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=39+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=6)  //Fenêtre centrée 50 pixel du haut suite au type Palette
		$Fen_Left:=3
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=100+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=7)  //Fenêtre centrée / liste 50 pixel du haut suite au type Palette
		$Fen_Left:=(625/2)-($1/2)
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=104+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=8)  //Fenêtre centrée 250 pixel du haut
		$Fen_Left:=(<>vl_EcranL/2)-($1/2)
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=250+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=10)  //Fenêtre calée à partir de la palette
		$Fen_Left:=160
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=39+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=11)  //Fenêtre centrée largeur    
		$Fen_Left:=(<>vl_EcranL/2)-($1/2)
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=33+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=12)  //Fenêtre standard    
		$Fen_Left:=(<>vl_EcranL/2)-($1/2)
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=33+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=14)  //Transmission à partir de la droite de la fenêtre de menu 
		$Fen_Right:=3+632
		$Fen_Left:=$Fen_Right-$1
		$Fen_Top:=110+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=18)
		$Fen_Left:=19
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=118
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=20)
		$Fen_Left:=(<>vl_EcranL/2)-($1/2)
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=250  //+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=21)
		//23/5/2012
		$Fen_Left:=665
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=33+$Fen_Offset+5
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=22)
		//23/5/2012
		$Fen_Left:=665
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=33+$Fen_Offset+5+40
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=25)
		$Fen_Left:=230
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=100  //+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=31)  //Fenêtre centrée 120 pixel du haut
		$Fen_Left:=(<>vl_EcranL/2)-($1/2)+30
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=120+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=32)  //Fenêtre centrée 120 pixel du haut
		$Fen_Left:=150
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=120+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=33)  //Fenêtre standard    décalée MAIN
		$Fen_Left:=632+30
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=33+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
	: ($5=34)  //Fenêtre standard    décalée MAIN sous palette appel
		$Fen_Left:=632+30
		$Fen_Right:=$Fen_Left+$1
		$Fen_Top:=80+$Fen_Offset
		$Fen_Bottom:=$Fen_Top+$2
End case 

If ($6="")
	$0:=Open window:C153($Fen_Left; $Fen_Top; $Fen_Right; $Fen_Bottom; $3; $4)
Else 
	$0:=Open window:C153($Fen_Left; $Fen_Top; $Fen_Right; $Fen_Bottom; $3; $4; $6)
End if 