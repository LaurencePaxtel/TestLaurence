//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_VoirNotes  
//{
//{          Lundi 28 Juillet 1997 à 17:02:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ([HeBerge:4]HB_ReferenceID:1>0)
	Process_Go2(-><>PR_HBNotes; "Go_HébergementNotes"; "Notes"; 32; [HeBerge:4]HB_ReferenceID:1; "N")
Else 
	StrAlerte(3; "")
End if 