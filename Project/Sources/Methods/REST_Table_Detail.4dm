//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 26/08/21, 15:41:35
// ----------------------------------------------------
// Méthode : REST_Table_Detail
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)

C_TEXT:C284($vt_nom)
C_LONGINT:C283($vl_table; $vl_champ; $vl_type)
C_POINTER:C301($vp_table)
C_OBJECT:C1216($vo)

$vp_table:=$2
$vl_table:=Table:C252($vp_table)

For ($vl_champ; 1; Get last field number:C255($vp_table))
	
	If (Is field number valid:C1000($vl_table; $vl_champ))
		$vp_champ:=Field:C253($vl_table; $vl_champ)
		$vl_type:=Type:C295($vp_champ->)
		$vt_nom:=Field name:C257($vp_champ)
		
		Case of 
			: ($vl_type=Est un numérique:K8:4) & (($vl_table=86) | ($vl_table=87))  // [Factures], [Factures_Lignes] arrondi des numériques à 2 décimales, demande Mahé
				$val:=Round:C94($vp_champ->; 2)
				OB_Fixer_reel(->$vo; $vt_nom; $val)
			: ($vl_type=Est une date:K8:7)
				OB_Fixer_date(->$vo; $vt_nom; $vp_champ->)
				$vt_date:=String:C10(Day of:C23($vp_champ->); "00")+"/"+String:C10(Month of:C24($vp_champ->); "00")+"/"+String:C10(Year of:C25($vp_champ->); "0000")
				OB_Fixer_texte(->$vo; $vt_nom+"_FR"; $vt_date)  // on passe la date en jj/mm/aaaa
			: ($vl_type=Est un entier:K8:5) | ($vl_type=Est un entier long:K8:6) | ($vl_type=Est un numérique:K8:4) | ($vl_type=Est un booléen:K8:9) | ($vl_type=Est une date:K8:7) | ($vl_type=Est un texte:K8:3) | ($vl_type=Est un champ alpha:K8:1)
				OB_Fixer_type_indefini(->$vo; $vt_nom; $vp_champ)
		End case 
		
	End if 
	
End for 

$0:=$vo