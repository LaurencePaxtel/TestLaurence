
If ([DossierPsycho:28]DY_Référence:1>0)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[DossierPsycho:28]DY_HB_ID:10)
	If (Records in selection:C76([HeBerge:4])=1)
		If (F_UnDossierTypeNotes(->[HeBerge:4]; "HB_NotesDossierPsycho"; "Note dossier psycho"; "Quit_HBNotesDY"))
		End if 
	End if 
End if 
