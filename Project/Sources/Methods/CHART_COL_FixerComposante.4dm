//%attributes = {}
//COLOR_FixerComposante
//$1=ANGLE DE LA COULEUR DANS LA ROUE CHROMATIQUE ENTRE -360 ET 360°
//$0 = Composante entre 0 et 65535

C_REAL:C285($1; $AngleCouleur; $IncrementParDegre)
C_LONGINT:C283($0)

$AngleCouleur:=($1+360)%360  //Ramène l'angle entre 0 et 360°
$IncrementParDegre:=65535/60

Case of 
	: ($AngleCouleur<=60)
		$0:=0xFFFF
		
	: ($AngleCouleur<120)
		$0:=(120-$AngleCouleur)*$IncrementParDegre
		
	: ($AngleCouleur<=240)
		$0:=0
		
	: ($AngleCouleur<300)
		$0:=($AngleCouleur-240)*$IncrementParDegre
		
	Else 
		$0:=0xFFFF  //65535
End case 