//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 08/06/23, 14:57:00
// ----------------------------------------------------
// Méthode : P_ChampAttribut
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer

var $varName_t; $varNameB_t : Text
var $i_el; $j_el : Integer

$j_el:=Size of array:C274(<>te_RdsRub{$1})

// Modifié par : Scanu Rémy (08/06/2023)
For ($i_el; 1; $j_el)
	
	If (<>te_RdsRub{$1}{$i_el}>0)
		$varName_t:=String:C10(<>te_RdsRub{$1}{$i_el}; "000")+"_@"
		
		OBJECT SET VISIBLE:C603(*; $varName_t; <>tb_RdsVis{$1}{$i_el})  // Gestion de l'affichage à l'écran
		OBJECT SET ENTERABLE:C238(Field:C253(<>te_RdsFic{$1}{$i_el}; <>te_RdsRub{$1}{$i_el})->; <>tb_RdsSais{$1}{$i_el})  // Gestion de la saisie
		
		If (<>tb_RdsVis{$1}{$i_el}=True:C214)  // Si on indique que le champ est visible
			// Gestion des pictogrammes pour indiquer que le champ est modifiable
			$varName_t:=String:C10(<>te_RdsRub{$1}{$i_el}; "000")+"_ico1"
			$varNameB_t:=String:C10(<>te_RdsRub{$1}{$i_el}; "000")+"_bt"
			
			OBJECT SET VISIBLE:C603(*; $varName_t; <>tb_RdsMod{$1}{$i_el})
			OBJECT SET VISIBLE:C603(*; $varNameB_t; <>tb_RdsMod{$1}{$i_el})
			
			// Gestion du pictogramme pour indiquer que le champ est obligatoire
			$varName_t:=String:C10(<>te_RdsRub{$1}{$i_el}; "000")+"_ico2"
			OBJECT SET VISIBLE:C603(*; $varName_t; <>tb_RdsObli{$1}{$i_el})
		End if 
		
	End if 
	
	CLEAR VARIABLE:C89($varName_t)
End for 