//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 04/11/22, 16:31:57
// ----------------------------------------------------
// Méthode : LB_Store_tableau_en_memoire
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($pos; $position_insertion)
C_POINTER:C301($ptr_liste_box_courante)

$ptr_liste_box_courante:=$1

// On ré-initialise les tableaux a zero
// LB_init_tableau_descriptif_LB 

// On cherche dans quel indice ce trouve le tableau de la liste_box actuelle
$pos:=Find in array:C230(liste_des_LB; ($ptr_liste_box_courante))

If ($pos<1)  // On a pas trouvé les info de la listebox dans le tableau 2D
	
	// On va devoir les créer
	APPEND TO ARRAY:C911(liste_des_LB; $ptr_liste_box_courante)
	APPEND TO ARRAY:C911(liste_des_LB_position; Liste_formulaire)
	APPEND TO ARRAY:C911(LB_nombre_insertion_de_colonne; nombre_d_insertion_de_colonne)
	
	$position_insertion:=Size of array:C274(LB_TA_titre_colonne)+1
	INSERT IN ARRAY:C227(LB_TA_titre_colonne; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TT_contenu_colonne; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TE_Largeur_colonne; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TT_Type_donnee_colonne; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TA_nom_var_entete; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TA_entete; $position_insertion; 1)
	
	INSERT IN ARRAY:C227(LB_TE_Alignement_colonne; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TE_Style_colonne; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TT_Police_colonne; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TE_couleur_fond_colonne; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TE_couleur_police_colonne; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TT_formatage_colonne; $position_insertion; 1)
	
	INSERT IN ARRAY:C227(LB_TE_Alignement_entete; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TE_Style_entete; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TT_Police_entete; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TE_couleur_fond_entete; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TE_couleur_police_entete; $position_insertion; 1)
	INSERT IN ARRAY:C227(LB_TE_taille_police; $position_insertion; 1)
	$pos:=$position_insertion
End if 

liste_des_LB_position{$pos}:=Liste_formulaire
LB_nombre_insertion_de_colonne{$pos}:=nombre_d_insertion_de_colonne

COPY ARRAY:C226(TA_titre_colonne; LB_TA_titre_colonne{$pos})
COPY ARRAY:C226(TT_contenu_colonne; LB_TT_contenu_colonne{$pos})
COPY ARRAY:C226(TE_Largeur_colonne; LB_TE_Largeur_colonne{$pos})
COPY ARRAY:C226(TT_Type_donnee_colonne; LB_TT_Type_donnee_colonne{$pos})
COPY ARRAY:C226(TA_nom_var_entete; LB_TA_nom_var_entete{$pos})
COPY ARRAY:C226(TA_entete; LB_TA_entete{$pos})

COPY ARRAY:C226(TE_Alignement_colonne; LB_TE_Alignement_colonne{$pos})
COPY ARRAY:C226(TE_Style_colonne; LB_TE_Style_colonne{$pos})
COPY ARRAY:C226(TT_Police_colonne; LB_TT_Police_colonne{$pos})
COPY ARRAY:C226(TE_couleur_fond_colonne; LB_TE_couleur_fond_colonne{$pos})
COPY ARRAY:C226(TE_couleur_police_colonne; LB_TE_couleur_police_colonne{$pos})
COPY ARRAY:C226(TT_formatage_colonne; LB_TT_formatage_colonne{$pos})

COPY ARRAY:C226(TE_Alignement_entete; LB_TE_Alignement_entete{$pos})
COPY ARRAY:C226(TE_Style_entete; LB_TE_Style_entete{$pos})
COPY ARRAY:C226(TT_Police_entete; LB_TT_Police_entete{$pos})
COPY ARRAY:C226(TE_couleur_fond_entete; LB_TE_couleur_fond_entete{$pos})
COPY ARRAY:C226(TE_couleur_police_entete; LB_TE_couleur_police_entete{$pos})
COPY ARRAY:C226(TE_taille_police; LB_TE_taille_police{$pos})