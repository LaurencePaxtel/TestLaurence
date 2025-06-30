//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 21/09/2020, 08:16:23
// ----------------------------------------------------
// Method: LB_Load_Liste
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_TEXT:C284(the_menu_URL)
		C_BOOLEAN:C305(deploye)
		
		GOTO OBJECT:C206(The_List_Box)
		LISTBOX SET TABLE SOURCE:C1013(The_List_Box; Table:C252(file_ptr))
		
		LB_init_tableau_descriptif_LB
		the_ptr_file_liste_box_courante:=file_ptr
		
		Case of 
			: ((Liste_ref_formulaire{Liste_formulaire}#"") & (Liste_ref_formulaire{Liste_formulaire}#"defaut"))
				QUERY:C277([Preferences:81]; [Preferences:81]UID:1=Liste_ref_formulaire{Liste_formulaire})
				
				LB_Blob_To_Array([Preferences:81]PREF_Informations:11)
				
				LB_Store_tableau_en_memoire(->The_List_Box)
				LB_Create_List_From_Array(->The_List_Box; True:C214)
			Else 
				EXECUTE METHOD:C1007(Proc_Fix_list_box)
				
				LB_Store_tableau_en_memoire(->The_List_Box)
		End case 
		
		OBJECT SET ENTERABLE:C238(The_List_Box; False:C215)
		GOTO OBJECT:C206(The_List_Box)
End case 