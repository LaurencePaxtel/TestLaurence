//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/09/2020, 03:28:48
// ----------------------------------------------------
// Method: LB_Generate_Hierarchical_Menu
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284($menu3)
C_LONGINT:C283($num_table)
C_BOOLEAN:C305($effacement)
C_POINTER:C301($file_ptr)

$file_ptr:=$1

$num_table:=Table:C252(file_ptr)
$champs:=Get last field number:C255($num_table)

menu:=Create menu:C408
APPEND TO ARRAY:C911(Les_menu; menu)

menu10:=Create menu:C408
APPEND TO ARRAY:C911(Les_menu; menu10)

en_tete:="I_"
ref_menu:=menu10

$menu3:=Create menu:C408
APPEND TO ARRAY:C911(Les_menu; $menu3)

For ($i; 1; Size of array:C274(Liste_formulaire))
	APPEND MENU ITEM:C411($menu3; Liste_formulaire{$i})
	
	If (Liste_formulaire=$i)
		SET MENU ITEM MARK:C208($menu3; -1; Char:C90(18))
	End if 
	
	SET MENU ITEM PARAMETER:C1004($menu3; -1; "Sel_format_"+String:C10($i))
End for 

APPEND MENU ITEM:C411($menu3; "(-")

APPEND MENU ITEM:C411($menu3; "Ajouter un modèle")
SET MENU ITEM PARAMETER:C1004($menu3; -1; "New_format")

$effacement:=True:C214

Case of 
	: (Liste_type_formulaire{Liste_formulaire}="USR")
		$a:=Count in array:C907(Liste_type_formulaire; "USR")
		
		If ($a=1)
			$effacement:=False:C215
		End if 
		
	: (Liste_type_formulaire{Liste_formulaire}="ENT")
		$effacement:=False:C215
	: (Liste_type_formulaire{Liste_formulaire}="GEN")
		$effacement:=False:C215
	: (Liste_type_formulaire{Liste_formulaire}="defaut")
		$effacement:=False:C215
End case 

If ($effacement)
	APPEND MENU ITEM:C411($menu3; "Renommer le modèle")
	SET MENU ITEM PARAMETER:C1004($menu3; -1; "rename_format")
	
	APPEND MENU ITEM:C411($menu3; "Supprimer le modèle")
	SET MENU ITEM PARAMETER:C1004($menu3; -1; "del_format")
End if 

APPEND MENU ITEM:C411(menu; "Gestion des modèles d'affichage"; $menu3)
APPEND MENU ITEM:C411(menu; "(-")

LB_Generate_Menu_Fields($file_ptr)

APPEND MENU ITEM:C411(menu; "Insérer une colonne"; menu10)
SET MENU ITEM PARAMETER:C1004(menu; -1; "Insert")

APPEND MENU ITEM:C411(menu; "Supprimer la colonne")
SET MENU ITEM PARAMETER:C1004(menu; -1; "sup")

menu3:=Create menu:C408
APPEND TO ARRAY:C911(Les_menu; menu3)

en_tete:="C_"
ref_menu:=menu3
LB_Generate_Menu_Fields($file_ptr)

APPEND MENU ITEM:C411(menu; "Changer le contenu"; menu3)
$0:=menu