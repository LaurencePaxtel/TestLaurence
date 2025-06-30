
If ([DossierInfirmie:27]DI_HB_ID:10>0)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[DossierInfirmie:27]DI_HB_ID:10)
	If (Records in selection:C76([HeBerge:4])=1)
		If (F_UnDossierTypeNotes(->[HeBerge:4]; "HB_NotesDossierInfirmier"; "Note dossier infirmier"; "Quit_HBNotesDI"))
		End if 
	End if 
End if 
