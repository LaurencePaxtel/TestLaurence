//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DemNote
//{
//{          Mardi 20 avril 1999 à 10:25:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If ([HeBerge:4]HB_ReferenceID:1>0)
	
	
	If ((<>vb_T_NoteMARNonModifiables=False:C215) | User in group:C338(Current user:C182; <>Groupe_NotesMARModife))
		
		If (F_UnDossierTypeNotes2(->[HeBerge:4]; "HB_NotesMaraude2"; "Note maraude"; "Quit_HBNotesMR"))
		End if 
		
	Else 
		If (F_UnDossierTypeNotes2(->[HeBerge:4]; "HB_NotesMaraude2F"; "Note maraude"; "Quit_HBNotesMRF"))
		End if 
	End if 
	
End if 