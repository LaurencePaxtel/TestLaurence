// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 23/09/2020, 09:42:58
// ----------------------------------------------------
// Method: [DiaLogues].DL_HébergementVeille_b.Popup Liste déroulante
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($liste; $nb_colonne)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Read only state:C362([Preferences:81]))
			READ WRITE:C146([Preferences:81])
		End if 
		
		QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=<>Ref_User_actif; *)
		QUERY:C277([Preferences:81];  & [Preferences:81]PREF_Type:2="Format_liste_selected")
		MultiSoc_Filter(->[Preferences:81])
		
		If (Records in selection:C76([Preferences:81])=1)
			$liste:=Find in array:C230(Liste_formulaire; [Preferences:81]PREF_Info_plus_2:24)
			
			Case of 
				: ($liste>0)
					Liste_formulaire:=$liste
				: (Size of array:C274(Liste_formulaire)>0)
					Liste_formulaire:=1
			End case 
			
		End if 
		
		If ((Liste_formulaire>0) & (Liste_formulaire<=Size of array:C274(Liste_formulaire)))
			
			Case of 
				: ((Liste_type_formulaire{Liste_formulaire}="USR") & (Liste_ref_formulaire{Liste_formulaire}#"") | (Liste_type_formulaire{Liste_formulaire}="GEN") | (Liste_type_formulaire{Liste_formulaire}="ENT"))
					nombre_d_insertion_de_colonne:=0
					
					QUERY:C277([Preferences:81]; [Preferences:81]UID:1=Liste_ref_formulaire{Liste_formulaire})
					MultiSoc_Filter(->[Preferences:81])
					
					If (Records in selection:C76([Preferences:81])=1)
						nombre_d_insertion_de_colonne:=0
						
						$nb_colonne:=LISTBOX Get number of columns:C831(The_List_Box)
						LISTBOX DELETE COLUMN:C830(The_List_Box; 1; $nb_colonne)
						
						LB_Blob_To_Array([Preferences:81]PREF_Informations:11)
						LB_Store_tableau_en_memoire(->The_List_Box)
						LB_Create_List_From_Array(->The_List_Box; True:C214)
					End if 
					
				: ((Liste_type_formulaire{Liste_formulaire}="defaut") | ((Liste_type_formulaire{Liste_formulaire}="USR") & (Liste_ref_formulaire{Liste_formulaire}="")))
					nombre_d_insertion_de_colonne:=0
					
					$nb_colonne:=LISTBOX Get number of columns:C831(The_List_Box)
					LISTBOX DELETE COLUMN:C830(The_List_Box; 1; $nb_colonne)
					
					LB_init_tableau_descriptif_LB
					
					EXECUTE METHOD:C1007(Proc_Fix_list_box)
					LB_Store_tableau_en_memoire(->The_List_Box)
			End case 
			
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		
		If ((Liste_formulaire>0) & (Liste_formulaire<=Size of array:C274(Liste_formulaire)))
			
			Case of 
				: ((Liste_type_formulaire{Liste_formulaire}="USR") & (Liste_ref_formulaire{Liste_formulaire}#"") | (Liste_type_formulaire{Liste_formulaire}="GEN") | (Liste_type_formulaire{Liste_formulaire}="ENT"))
					nombre_d_insertion_de_colonne:=0
					
					QUERY:C277([Preferences:81]; [Preferences:81]UID:1=Liste_ref_formulaire{Liste_formulaire})
					MultiSoc_Filter(->[Preferences:81])
					
					If (Records in selection:C76([Preferences:81])=1)
						$nb_colonne:=LISTBOX Get number of columns:C831(The_List_Box)
						LISTBOX DELETE COLUMN:C830(The_List_Box; 1; $nb_colonne)
						
						LB_Blob_To_Array([Preferences:81]PREF_Informations:11)
						LB_Store_tableau_en_memoire(->The_List_Box)
						LB_Create_List_From_Array(->The_List_Box; True:C214)
					End if 
					
				: ((Liste_type_formulaire{Liste_formulaire}="defaut") | ((Liste_type_formulaire{Liste_formulaire}="USR") & (Liste_ref_formulaire{Liste_formulaire}="")))
					nombre_d_insertion_de_colonne:=0
					$nb_colonne:=LISTBOX Get number of columns:C831(The_List_Box)
					
					LISTBOX DELETE COLUMN:C830(The_List_Box; 1; $nb_colonne)
					LB_init_tableau_descriptif_LB
					
					EXECUTE METHOD:C1007(Proc_Fix_list_box)
					LB_Store_tableau_en_memoire(->The_List_Box)
			End case 
			
			If (Read only state:C362([Preferences:81]))
				READ WRITE:C146([Preferences:81])
			End if 
			
			QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=<>Ref_User_actif; *)
			QUERY:C277([Preferences:81];  & [Preferences:81]PREF_Type:2="Format_liste_selected")
			
			MultiSoc_Filter(->[Preferences:81])
			
			If (Records in selection:C76([Preferences:81])=0)
				CREATE RECORD:C68([Preferences:81])
				MultiSoc_Init_Structure(->[Preferences:81])
				
				[Preferences:81]PREF_UID_user:7:=<>Ref_User_actif
				[Preferences:81]PREF_Type:2:="Format_liste_selected"
			End if 
			
			[Preferences:81]PREF_Info_plus_2:24:=Liste_formulaire{Liste_formulaire}
			SAVE RECORD:C53([Preferences:81])
			
			If (Not:C34(Read only state:C362([Preferences:81])))
				READ ONLY:C145([Preferences:81])
			End if 
			
		End if 
		
End case 