//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_VoirNotes  
//{
//{          Lundi 28 Juillet 1997 à 17:02:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================



If ([DossierSocial:25]DS_HB_ID:10>0)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[DossierSocial:25]DS_HB_ID:10)
	If (Records in selection:C76([HeBerge:4])=1)
		If (F_UnDossierTypeNotes2(->[HeBerge:4]; "HB_NotesDossierSocial2"; "Note dossier social"; "Quit_HBNotesDS"))
		End if 
	End if 
End if 
