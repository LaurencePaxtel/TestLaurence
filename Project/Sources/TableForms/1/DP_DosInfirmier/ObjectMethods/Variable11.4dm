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
	If (F_UnDossierTypeNotes(->[HeBerge:4]; "HB_NotesDossierInfirmier"; "Note dossier infirmier"; "Quit_HBNotesDI"))
	End if 
End if 