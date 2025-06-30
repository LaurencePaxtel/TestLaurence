//%attributes = {}
//OB_Fixer_type_indefini


// OD pour envoyer une valeur sans connaître le type de champ

$vp_objet:=$1
$vt_lib:=$2
$vp_champ:=$3

$vl_type:=Type:C295($vp_champ->)

Case of 
	: ($vl_type=Est un entier:K8:5) | ($vl_type=Est un entier long:K8:6)
		OB_Fixer_entier_long($vp_objet; $vt_lib; $vp_champ->)
		
	: ($vl_type=Est un numérique:K8:4)
		OB_Fixer_reel($vp_objet; $vt_lib; $vp_champ->)
		
	: ($vl_type=Est une date:K8:7)
		OB_Fixer_date($vp_objet; $vt_lib; $vp_champ->)
		
	: ($vl_type=Est un booléen:K8:9)
		OB_Fixer_booleen($vp_objet; $vt_lib; $vp_champ->)
		
	: ($vl_type=Est une date:K8:7)
		OB_Fixer_date($vp_objet; $vt_lib; $vp_champ->)
		
	: ($vl_type=Est un texte:K8:3) | ($vl_type=Est un champ alpha:K8:1)
		OB_Fixer_texte($vp_objet; $vt_lib; $vp_champ->)
		
		
		
	Else 
		
End case 
