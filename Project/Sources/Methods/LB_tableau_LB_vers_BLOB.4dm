//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 21/09/2020, 12:17:17
// ----------------------------------------------------
// Method: LB_tableau_LB_vers_BLOB
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BLOB:C604($0)

C_LONGINT:C283($offset)
C_BLOB:C604($blob)

VARIABLE TO BLOB:C532(TA_titre_colonne; $blob; $offset)
VARIABLE TO BLOB:C532(TT_contenu_colonne; $blob; $offset)
VARIABLE TO BLOB:C532(TE_Largeur_colonne; $blob; $offset)
VARIABLE TO BLOB:C532(TT_Type_donnee_colonne; $blob; $offset)
VARIABLE TO BLOB:C532(TA_nom_var_entete; $blob; $offset)
VARIABLE TO BLOB:C532(TA_entete; $blob; $offset)

VARIABLE TO BLOB:C532(TE_Alignement_colonne; $blob; $offset)
VARIABLE TO BLOB:C532(TE_Style_colonne; $blob; $offset)
VARIABLE TO BLOB:C532(TT_Police_colonne; $blob; $offset)
VARIABLE TO BLOB:C532(TE_couleur_fond_colonne; $blob; $offset)
VARIABLE TO BLOB:C532(TE_couleur_police_colonne; $blob; $offset)
VARIABLE TO BLOB:C532(TT_formatage_colonne; $blob; $offset)

VARIABLE TO BLOB:C532(TE_Alignement_entete; $blob; $offset)
VARIABLE TO BLOB:C532(TE_Style_entete; $blob; $offset)
VARIABLE TO BLOB:C532(TT_Police_entete; $blob; $offset)
VARIABLE TO BLOB:C532(TE_couleur_fond_entete; $blob; $offset)
VARIABLE TO BLOB:C532(TE_couleur_police_entete; $blob; $offset)
VARIABLE TO BLOB:C532(TE_taille_police; $blob; $offset)

$0:=$blob