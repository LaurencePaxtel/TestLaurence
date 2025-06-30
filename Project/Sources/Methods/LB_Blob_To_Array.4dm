//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/09/2020, 16:31:34
// ----------------------------------------------------
// Method: LB_Blob_To_Array
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BLOB:C604($1)

C_LONGINT:C283($offset)
C_BLOB:C604($blob)

$blob:=$1

BLOB TO VARIABLE:C533($blob; TA_titre_colonne; $offset)
BLOB TO VARIABLE:C533($blob; TT_contenu_colonne; $offset)
BLOB TO VARIABLE:C533($blob; TE_Largeur_colonne; $offset)
BLOB TO VARIABLE:C533($blob; TT_Type_donnee_colonne; $offset)
BLOB TO VARIABLE:C533($blob; TA_nom_var_entete; $offset)
BLOB TO VARIABLE:C533($blob; TA_entete; $offset)

BLOB TO VARIABLE:C533($blob; TE_Alignement_colonne; $offset)
BLOB TO VARIABLE:C533($blob; TE_Style_colonne; $offset)
BLOB TO VARIABLE:C533($blob; TT_Police_colonne; $offset)
BLOB TO VARIABLE:C533($blob; TE_couleur_fond_colonne; $offset)
BLOB TO VARIABLE:C533($blob; TE_couleur_police_colonne; $offset)
BLOB TO VARIABLE:C533($blob; TT_formatage_colonne; $offset)

BLOB TO VARIABLE:C533($blob; TE_Alignement_entete; $offset)
BLOB TO VARIABLE:C533($blob; TE_Style_entete; $offset)
BLOB TO VARIABLE:C533($blob; TT_Police_entete; $offset)
BLOB TO VARIABLE:C533($blob; TE_couleur_fond_entete; $offset)
BLOB TO VARIABLE:C533($blob; TE_couleur_police_entete; $offset)
BLOB TO VARIABLE:C533($blob; TE_taille_police; $offset)
