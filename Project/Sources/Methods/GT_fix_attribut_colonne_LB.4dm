//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 29/09/2020, 08:14:52
// ----------------------------------------------------
// Method: GT_fix_attribut_colonne_LB
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($2; $ptr_liste_box_courante)
$ptr_liste_box_courante:=$2

$i:=$1

$nb_col:=LISTBOX Get number of columns:C831($ptr_liste_box_courante->)
$col:="C_"+String:C10($nb_col)
$nom_entete:="head"+String:C10($nb_col)
$head:=Get pointer:C304($nom_entete)


LISTBOX SET COLUMN WIDTH:C833(*; $col; TE_Largeur_colonne{$i})

OBJECT SET FONT:C164(*; $col; TT_Police_colonne{$i})
OBJECT SET FONT:C164($head->; TT_Police_entete{$i})

OBJECT SET FONT STYLE:C166(*; $col; TE_Style_colonne{$i})
OBJECT SET FONT STYLE:C166($head->; TE_Style_entete{$i})

OBJECT SET FORMAT:C236(*; $col; TT_formatage_colonne{$i})

If (TE_couleur_fond_colonne{$i}#0)
	OBJECT SET RGB COLORS:C628(*; $col; TE_couleur_police_colonne{$i}; TE_couleur_fond_colonne{$i})
Else 
	OBJECT SET RGB COLORS:C628(*; $col; TE_couleur_police_colonne{$i}; Coul arrière plan:K23:2)
End if 
OBJECT SET RGB COLORS:C628($head->; TE_couleur_police_entete{$i}; Coul arrière plan:K23:2)

OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $col; TE_Alignement_colonne{$i})
OBJECT SET HORIZONTAL ALIGNMENT:C706($head->; TE_Alignement_entete{$i})

OBJECT SET FONT SIZE:C165(*; $col; TE_taille_police{$i})
OBJECT SET FONT SIZE:C165($head->; TE_taille_police{$i})
