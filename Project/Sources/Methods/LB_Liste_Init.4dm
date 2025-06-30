//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/09/2020, 17:39:47
// ----------------------------------------------------
// Method: LB_Liste_Init
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(Proc_Fix_list_box; File_abrev; Formulaire_liste)
C_LONGINT:C283(nombre_d_insertion_de_colonne)
C_POINTER:C301(file_ptr)

ARRAY TEXT:C222(LB_TA_titre_colonne; 0; 0)
ARRAY TEXT:C222(LB_TT_contenu_colonne; 0; 0)
ARRAY TEXT:C222(LB_TA_nom_var_entete; 0; 0)
ARRAY TEXT:C222(LB_TA_entete; 0; 0)
ARRAY TEXT:C222(LB_TT_Police_colonne; 0; 0)
ARRAY TEXT:C222(LB_TT_formatage_colonne; 0; 0)
ARRAY TEXT:C222(LB_TT_Police_entete; 0; 0)

ARRAY LONGINT:C221(liste_des_LB_position; 0)
ARRAY LONGINT:C221(LB_nombre_insertion_de_colonne; 0)
ARRAY LONGINT:C221(LB_TE_Largeur_colonne; 0; 0)
ARRAY LONGINT:C221(LB_TT_Type_donnee_colonne; 0; 0)
ARRAY LONGINT:C221(LB_TE_Alignement_colonne; 0; 0)
ARRAY LONGINT:C221(LB_TE_Style_colonne; 0; 0)
ARRAY LONGINT:C221(LB_TE_couleur_fond_colonne; 0; 0)
ARRAY LONGINT:C221(LB_TE_couleur_police_colonne; 0; 0)
ARRAY LONGINT:C221(LB_TE_Alignement_entete; 0; 0)
ARRAY LONGINT:C221(LB_TE_Style_entete; 0; 0)
ARRAY LONGINT:C221(LB_TE_couleur_fond_entete; 0; 0)
ARRAY LONGINT:C221(LB_TE_couleur_police_entete; 0; 0)
ARRAY LONGINT:C221(LB_TE_taille_police; 0; 0)

ARRAY POINTER:C280(liste_des_LB; 0)
ARRAY POINTER:C280(Autre_table_pour_liste; 1)

ARRAY POINTER:C280(<>TP_table_a_complement; 1)
ARRAY POINTER:C280(<>TP_table_de_complement; 1)
ARRAY POINTER:C280(<>TP_lien_de_complement; 1)

File_abrev:="HG"
Nom_pref_recherche:="Société"
Proc_Fix_list_box:="LB_HG_Liste_Defaut"

If (Formulaire_liste="")
	Formulaire_liste:="Liste_generale"
End if 

file_ptr:=->[HeberGement:5]
Autre_table_pour_liste{1}:=->[HeBerge:4]

insertion_dans_tableau:=True:C214

<>TP_table_a_complement{1}:=->[HeberGement:5]
<>TP_table_de_complement{1}:=->[HeBerge:4]
<>TP_lien_de_complement{1}:=->[HeBerge:4]HB_ReferenceID:1