//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/09/2020, 10:49:44
// ----------------------------------------------------
// Method: LB_Load_Array_To_Memory
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $file_Ptr)
C_POINTER:C301($2; $ptr_liste_box_courante)
C_LONGINT:C283($pos)

$file_Ptr:=$1
$ptr_liste_box_courante:=$2

//on ré-initialise les tableaux a zero
//LB_init_tableau_descriptif_LB 

//On cherche dans quel indice ce trouve le tableau de la liste_box actuelle
$pos:=Find in array:C230(liste_des_LB; ($ptr_liste_box_courante))
If ($pos>0)  //on a trouvé les info de la listebox dans le tableau 2D
	
	Liste_formulaire:=liste_des_LB_position{$pos}
	nombre_d_insertion_de_colonne:=LB_nombre_insertion_de_colonne{$pos}
	
	COPY ARRAY:C226(LB_TA_titre_colonne{$pos}; TA_titre_colonne)
	COPY ARRAY:C226(LB_TT_contenu_colonne{$pos}; TT_contenu_colonne)
	COPY ARRAY:C226(LB_TE_Largeur_colonne{$pos}; TE_Largeur_colonne)
	COPY ARRAY:C226(LB_TT_Type_donnee_colonne{$pos}; TT_Type_donnee_colonne)
	COPY ARRAY:C226(LB_TA_nom_var_entete{$pos}; TA_nom_var_entete)
	COPY ARRAY:C226(LB_TA_entete{$pos}; TA_entete)
	
	COPY ARRAY:C226(LB_TE_Alignement_colonne{$pos}; TE_Alignement_colonne)
	COPY ARRAY:C226(LB_TE_Style_colonne{$pos}; TE_Style_colonne)
	COPY ARRAY:C226(LB_TT_Police_colonne{$pos}; TT_Police_colonne)
	COPY ARRAY:C226(LB_TE_couleur_fond_colonne{$pos}; TE_couleur_fond_colonne)
	COPY ARRAY:C226(LB_TE_couleur_police_colonne{$pos}; TE_couleur_police_colonne)
	COPY ARRAY:C226(LB_TT_formatage_colonne{$pos}; TT_formatage_colonne)
	
	COPY ARRAY:C226(LB_TE_Alignement_entete{$pos}; TE_Alignement_entete)
	COPY ARRAY:C226(LB_TE_Style_entete{$pos}; TE_Style_entete)
	COPY ARRAY:C226(LB_TT_Police_entete{$pos}; TT_Police_entete)
	COPY ARRAY:C226(LB_TE_couleur_fond_entete{$pos}; TE_couleur_fond_entete)
	COPY ARRAY:C226(LB_TE_couleur_police_entete{$pos}; TE_couleur_police_entete)
	COPY ARRAY:C226(LB_TE_taille_police{$pos}; TE_taille_police)
Else 
	//il y a un problème
	//TRACE
End if 