
If ([DossierMedical:29]DM_Référence:1>0)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[DossierMedical:29]DM_HB_ID:10)
	If (Records in selection:C76([HeBerge:4])=1)
		If (F_UnDossierTypeNotes(->[HeBerge:4]; "HB_NotesDossierMédical"; "Note dossier médical"; "Quit_HBNotesDM"))
		End if 
	End if 
End if 
