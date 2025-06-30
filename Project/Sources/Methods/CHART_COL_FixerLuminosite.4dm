//%attributes = {}
//COLOR_FixerLuminosite
//$1,$2,$3 = COMPOSANTES ROUGE VERT BLEU DE LA COULEUR À MODIFIER
//$4 = LUMINOSITÉ A DONNER À LA COULEUR
//La luminosité est un entier entre -100 (noir total) et 100 (blanc), 0 = pas de 
//changement

C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($4; $ComposanteRouge; $ComposanteVert; $ComposanteBleu; $Luminosite)
C_REAL:C285($Fraction)

If ($4#0)  //0 = on ne change rien à la luminosité de la couleur
	$ComposanteRouge:=$1->
	$ComposanteVert:=$2->
	$ComposanteBleu:=$3->
	$Luminosite:=$4
	
	$Fraction:=$Luminosite/100  //$Fraction = 1 si $Luminosite = 100 (luminosité maximale)
	
	If ($Luminosite>0)  //On éclaircit la couleur
		$ComposanteRouge:=$ComposanteRouge+($Fraction*(65535-$ComposanteRouge))
		$ComposanteVert:=$ComposanteVert+($Fraction*(65535-$ComposanteVert))
		$ComposanteBleu:=$ComposanteBleu+($Fraction*(65535-$ComposanteBleu))
	Else   //On assombrit la couleur
		$ComposanteRouge:=$ComposanteRouge+($Fraction*$ComposanteRouge)  //Fraction est négatif !
		$ComposanteVert:=$ComposanteVert+($Fraction*$ComposanteVert)
		$ComposanteBleu:=$ComposanteBleu+($Fraction*$ComposanteBleu)
	End if 
	
	$1->:=$ComposanteRouge
	$2->:=$ComposanteVert
	$3->:=$ComposanteBleu
End if 