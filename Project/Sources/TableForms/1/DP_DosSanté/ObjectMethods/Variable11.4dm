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
	F_UnDossierTypeNotes(->[HeBerge:4]; "HB_NotesDossierSanté"; "Note dossier santé"; "Quit_HBNotesDE")
End if 