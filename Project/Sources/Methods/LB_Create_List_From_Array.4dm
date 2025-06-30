//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 27/09/2020, 15:42:06
// ----------------------------------------------------
// Method: LB_Create_List_From_Array
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_LONGINT:C283($code; $num_table; $num_champ)
C_BOOLEAN:C305($liste_box_generale)
C_POINTER:C301($ptr_liste_box_courante; $ptr_champ)
C_COLLECTION:C1488($column_c; $verif_c)

$ptr_liste_box_courante:=$1
$liste_box_generale:=$2

insertion_dans_tableau:=False:C215

// Modifié par : Scanu Rémy (07/11/2022)
$column_c:=New collection:C1472
Form:C1466.footerVar:=New collection:C1472

For ($i; 1; Size of array:C274(TT_contenu_colonne))
	
	Case of 
		: ((Num:C11(TT_contenu_colonne{$i})>10) & (Length:C16(TT_contenu_colonne{$i})<25))
			$code:=Num:C11(TT_contenu_colonne{$i})
			$num_table:=Int:C8($code/10000)
			$num_champ:=$code-($num_table*10000)
			$ptr_champ:=Field:C253($num_table; $num_champ)
			
			// Modifié par : Scanu Rémy (06/04/2023)
			// Correction bug, ajout de 2 colonnes identiques
			$verif_c:=$column_c.query("content = :1"; TT_contenu_colonne{$i})
			
			If ($verif_c.length=0)
				$verif_c:=$column_c.query("titre = :1"; TA_titre_colonne{$i})
				
				If ($verif_c.length=1)
					TA_titre_colonne{$i}:="Copy "+TA_titre_colonne{$i}
				End if 
				
				$column_c.push(New object:C1471("content"; TT_contenu_colonne{$i}; "titre"; TA_titre_colonne{$i}))
				
				LB_Insert_Column($ptr_liste_box_courante; $ptr_champ; TA_titre_colonne{$i}; ""; ""; TE_Largeur_colonne{$i})
			End if 
			
		Else 
			LB_Insert_Column_Form($ptr_liste_box_courante; TT_contenu_colonne{$i}; TA_titre_colonne{$i}; ""; ""; TE_Largeur_colonne{$i})
	End case 
	
	LB_Set_Style($i; $ptr_liste_box_courante)
End for 

insertion_dans_tableau:=True:C214
LB_Store_tableau_en_memoire($ptr_liste_box_courante)