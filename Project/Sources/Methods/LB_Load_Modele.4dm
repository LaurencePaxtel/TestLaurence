//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 26/09/2020, 08:01:43
// ----------------------------------------------------
// Method: LB_Load_Modele
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($liste_box_generale)
C_POINTER:C301($ptr_liste_box_courante)

$ptr_liste_box_courante:=$1
$liste_box_generale:=$2

If ((Liste_formulaire>0) & (Liste_formulaire<=Size of array:C274(Liste_formulaire)))
	
	Case of 
		: (Liste_ref_formulaire{Liste_formulaire}#"")
			nombre_d_insertion_de_colonne:=0
			
			QUERY:C277([Preferences:81]; [Preferences:81]UID:1=Liste_ref_formulaire{Liste_formulaire})
			$nb_colonne:=LISTBOX Get number of columns:C831($ptr_liste_box_courante->)
			
			LISTBOX DELETE COLUMN:C830($ptr_liste_box_courante->; 1; $nb_colonne)
			
			LB_Blob_To_Array([Preferences:81]PREF_Informations:11)
			LB_Store_tableau_en_memoire($ptr_liste_box_courante)
			LB_Create_List_From_Array($ptr_liste_box_courante; $liste_box_generale)
		: ((Liste_type_formulaire{Liste_formulaire}="defaut") | ((Liste_type_formulaire{Liste_formulaire}="USR") & (Liste_ref_formulaire{Liste_formulaire}="")))
			nombre_d_insertion_de_colonne:=0
			
			$nb_colonne:=LISTBOX Get number of columns:C831($ptr_liste_box_courante->)
			LISTBOX DELETE COLUMN:C830($ptr_liste_box_courante->; 1; $nb_colonne)
			
			LB_init_tableau_descriptif_LB
			
			If (Proc_Fix_list_box#"")
				EXECUTE METHOD:C1007(Proc_Fix_list_box)
			End if 
			
	End case 
	
	If (Read only state:C362([Preferences:81]))
		READ WRITE:C146([Preferences:81])
	End if 
	
	QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=<>Ref_User_actif; *)
	QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="Format_liste_selected")
	MultiSoc_Filter(->[Preferences:81])
	
	If (Records in selection:C76([Preferences:81])=0)
		CREATE RECORD:C68([Preferences:81])
		MultiSoc_Init_Structure(->[Preferences:81])
		[Preferences:81]PREF_UID_user:7:=<>Ref_User_actif
		[Preferences:81]PREF_Type:2:="Format_liste_selected"
	End if 
	
	[Preferences:81]PREF_Info_plus_2:24:=Liste_formulaire{Liste_formulaire}
	SAVE RECORD:C53([Preferences:81])
	
	READ ONLY:C145([Preferences:81])
End if 