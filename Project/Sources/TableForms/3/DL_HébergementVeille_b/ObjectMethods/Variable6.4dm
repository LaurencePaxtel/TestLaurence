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
LOAD RECORD:C52([HeberGement:5])

If ([HeberGement:5]HG_HB_ID:19>0)
	Process_Go2(-><>PR_HBNotes; "Go_HébergementNotes"; "Notes"; 32; [HeBerge:4]ID:65; "N")
Else 
	StrAlerte(5; "")
End if 