//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 22/09/2020, 16:15:30
// ----------------------------------------------------
// Method: LB_Manage_Header_Clic
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
C_POINTER:C301($3)

C_TEXT:C284($format_t; $col; $prefixe; $formatage)
C_LONGINT:C283($alignement; $position_el; $colonne; $num_champ; $num_table; $longueur_prefixe)
C_BOOLEAN:C305($liste_box_generale)
C_POINTER:C301($ptr_liste_box_courante; $file_ptr; $head)
C_BLOB:C604($blob)

$ptr_liste_box_courante:=$1
$liste_box_generale:=$2

If (Count parameters:C259>2)
	$file_ptr:=$3
Else 
	$file_ptr:=file_ptr
End if 

LB_Load_liste_des_Modeles

$pos:=Find in array:C230(liste_des_LB; ($ptr_liste_box_courante))

If ($pos>0)
	Liste_formulaire:=liste_des_LB_position{$pos}
Else 
	Liste_formulaire:=1
End if 

RESOLVE POINTER:C394(Self:C308; $vaNomVar; $vlNumTable; $vlNumChamp)

$colonne:=Find in array:C230(TA_nom_var_entete; $vaNomVar)
$col:="C_"+Substring:C12($vaNomVar; 5)
$head:=Get pointer:C304($vaNomVar)

$prefixe:=File_abrev+"_"
$longueur_prefixe:=Length:C16($prefixe)

If ($liste_box_generale=False:C215)
	ARRAY TEXT:C222(Les_menu; 0)
	
	$menu:=LB_Generate_Hierarchical_Menu($file_ptr)
	$a:=Dynamic pop up menu:C1006($menu)
	
	For ($i; 1; Size of array:C274(Les_menu))
		RELEASE MENU:C978(Les_menu{$i})
	End for 
	
	If ($a#"")
		
		Case of 
			: ($a="rename_format")
				LB_Modele_Rename
			: ($a="del_format")
				LB_Modele_Delete($ptr_liste_box_courante; $liste_box_generale)
			: ($a="New_format")
				LB_new_format($nom_pref_liste_box)
				
				$position_el:=Size of array:C274(Liste_formulaire)
				$format_t:=Liste_formulaire{Size of array:C274(Liste_formulaire)}
			: ($a="Sel_format_@")
				Liste_formulaire:=Num:C11(Substring:C12($a; 12))
				LB_Load_Modele($ptr_liste_box_courante; $liste_box_generale)
			: ($a="I_@")
				$largeur:=LISTBOX Get column width:C834(Self:C308->)
				$a:=Substring:C12($a; 3)
				
				Case of 
					: (Num:C11(Substring:C12($a; 1; 1))#0)  // on insere une colonne avec un champs
						$num_table:=Int:C8(Num:C11($a)/10000)
						
						$num_champ:=Num:C11($a)-($num_table*10000)
						$ptr_champ:=Field:C253($num_table; $num_champ)
						$nom_champs:=UTL_Champ_Get_Titre($num_table; $num_champ)
						
						Case of 
							: (Type:C295($ptr_champ->)=Est une date:K8:7)
								$formatage:=Char:C90(1)
								$alignement:=Aligné au centre:K42:3
							: (Type:C295($ptr_champ->)=Est une heure:K8:8)
								$formatage:=Char:C90(2)
								$alignement:=Aligné au centre:K42:3
						End case 
						
						LB_Insert_Column($ptr_liste_box_courante; $ptr_champ; $nom_champs; ""; $formatage; 120; "Faux"; ""; 0; 0; 0; $colonne; $alignement)
					Else   // On insère une colonne de type formule
						$pos:=Position:C15("_"; $a)
						$titre:=Substring:C12($a; $pos+1)
						
						LB_Insert_Column_Form($ptr_liste_box_courante; $a; $titre; ""; ""; 120; "Faux"; ""; 0; 0; 0; $colonne)
				End case 
				
			: ($a="sup")
				$sup_ok:=True:C214
				
				Case of 
					: (Size of array:C274(TA_titre_colonne)=1)
						$sup_ok:=False:C215
					: (($liste_box_generale=True:C214) & (Size of array:C274(TA_titre_colonne)=2))
						$sup_ok:=False:C215
				End case 
				
				If ($sup_ok)
					LISTBOX DELETE COLUMN:C830($ptr_liste_box_courante->; $colonne; 1)
					
					DELETE FROM ARRAY:C228(TA_titre_colonne; $colonne; 1)
					DELETE FROM ARRAY:C228(TT_contenu_colonne; $colonne; 1)
					DELETE FROM ARRAY:C228(TE_Largeur_colonne; $colonne; 1)
					DELETE FROM ARRAY:C228(TT_Type_donnee_colonne; $colonne; 1)
					DELETE FROM ARRAY:C228(TA_nom_var_entete; $colonne; 1)
					DELETE FROM ARRAY:C228(TA_entete; $colonne; 1)
					
					DELETE FROM ARRAY:C228(TE_Alignement_colonne; $colonne; 1)
					DELETE FROM ARRAY:C228(TE_Style_colonne; $colonne; 1)
					DELETE FROM ARRAY:C228(TT_Police_colonne; $colonne; 1)
					DELETE FROM ARRAY:C228(TE_couleur_fond_colonne; $colonne; 1)
					DELETE FROM ARRAY:C228(TE_couleur_police_colonne; $colonne; 1)
					DELETE FROM ARRAY:C228(TT_formatage_colonne; $colonne; 1)
					
					DELETE FROM ARRAY:C228(TE_Alignement_entete; $colonne; 1)
					DELETE FROM ARRAY:C228(TE_Style_entete; $colonne; 1)
					DELETE FROM ARRAY:C228(TT_Police_entete; $colonne; 1)
					DELETE FROM ARRAY:C228(TE_couleur_fond_entete; $colonne; 1)
					DELETE FROM ARRAY:C228(TE_couleur_police_entete; $colonne; 1)
					DELETE FROM ARRAY:C228(TE_taille_police; $colonne; 1)
				Else 
					ALERT:C41("Vous devez conserver une colonne de donnée au minimum.")
				End if 
				
			: ($a="C_@")  // Changement de contenu
				$a:=Substring:C12($a; 3)
				$largeur:=LISTBOX Get column width:C834(Self:C308->)
				
				LISTBOX DELETE COLUMN:C830($ptr_liste_box_courante->; $colonne; 1)
				DELETE FROM ARRAY:C228(TA_titre_colonne; $colonne; 1)
				DELETE FROM ARRAY:C228(TT_contenu_colonne; $colonne; 1)
				DELETE FROM ARRAY:C228(TE_Largeur_colonne; $colonne; 1)
				DELETE FROM ARRAY:C228(TT_Type_donnee_colonne; $colonne; 1)
				DELETE FROM ARRAY:C228(TA_nom_var_entete; $colonne; 1)
				DELETE FROM ARRAY:C228(TA_entete; $colonne; 1)
				
				DELETE FROM ARRAY:C228(TE_Alignement_colonne; $colonne; 1)
				DELETE FROM ARRAY:C228(TE_Style_colonne; $colonne; 1)
				DELETE FROM ARRAY:C228(TT_Police_colonne; $colonne; 1)
				DELETE FROM ARRAY:C228(TE_couleur_fond_colonne; $colonne; 1)
				DELETE FROM ARRAY:C228(TE_couleur_police_colonne; $colonne; 1)
				DELETE FROM ARRAY:C228(TT_formatage_colonne; $colonne; 1)
				
				DELETE FROM ARRAY:C228(TE_Style_entete; $colonne; 1)
				DELETE FROM ARRAY:C228(TT_Police_entete; $colonne; 1)
				DELETE FROM ARRAY:C228(TE_couleur_fond_entete; $colonne; 1)
				DELETE FROM ARRAY:C228(TE_couleur_police_entete; $colonne; 1)
				DELETE FROM ARRAY:C228(TE_taille_police; $colonne; 1)
				
				Case of 
					: (Num:C11(Substring:C12($a; 1; 1))#0)
						$num_table:=Int:C8(Num:C11($a)/10000)
						
						$num_champ:=Num:C11($a)-($num_table*10000)
						$ptr_champ:=Field:C253($num_table; $num_champ)
						$nom_champs:=UTL_Champ_Get_Titre($num_table; $num_champ)
						
						LB_Insert_Column($ptr_liste_box_courante; $ptr_champ; $nom_champs; ""; ""; $largeur; "Faux"; ""; 0; 11; 0; $colonne)
					Else 
						LB_Insert_Column_Form($ptr_liste_box_courante; $a; $a; ""; ""; $largeur; "Faux"; ""; 0; 11; 0; $colonne)
				End case 
				
		End case 
		
		$blob:=LB_tableau_LB_vers_BLOB
		
		LB_store_LB($blob; $nom_pref_liste_box)
		LB_Store_tableau_en_memoire($ptr_liste_box_courante)
	End if 
	
End if 

If ($format_t#"")
	$position_el:=Find in array:C230(Liste_formulaire; $format_t; 1)
	
	Liste_formulaire:=$position_el
	Liste_ref_formulaire:=$position_el
	Liste_type_formulaire:=$position_el
	
	nombre_d_insertion_de_colonne:=0
	QUERY:C277([Preferences:81]; [Preferences:81]UID:1=Liste_ref_formulaire{$position_el})
	
	If (Records in selection:C76([Preferences:81])=1)
		nombre_d_insertion_de_colonne:=0
		$nb_colonne:=LISTBOX Get number of columns:C831(The_List_Box)
		
		LISTBOX DELETE COLUMN:C830(The_List_Box; 1; $nb_colonne)
		
		LB_Blob_To_Array([Preferences:81]PREF_Informations:11)
		LB_Store_tableau_en_memoire(->The_List_Box)
		LB_Create_List_From_Array(->The_List_Box; True:C214)
	End if 
	
End if 