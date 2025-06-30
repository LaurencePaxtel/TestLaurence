//%attributes = {}
//OB_Lire

// générique Odrut

// OB_Lire ($vo;$vt_field_name;$vp_champ)

$vo:=$1
$vt_field_name:=$2
$vp_champ:=$3

$vl_type:=Type:C295($vp_champ->)
Case of 
	: ($vl_type=Est un texte:K8:3) | ($vl_type=Est un champ alpha:K8:1)
		$vp_champ->:=OB_Lire_texte($vo; $vt_field_name)
		
	: ($vl_type=Est un booléen:K8:9)
		$vp_champ->:=OB_Lire_booleen($vo; $vt_field_name)
		
	: ($vl_type=Est un entier:K8:5) | ($vl_type=Est un entier long:K8:6)
		$vp_champ->:=OB_Lire_entier_long($vo; $vt_field_name)
		
	: ($vl_type=Est un numérique:K8:4)
		$vp_champ->:=OB_Lire_reel($vo; $vt_field_name)
		
	Else 
		TRACE:C157
		
End case 