//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_VoirSP  
//{
//{          Lundi 28 Juillet 1997 à 17:09:03
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ([HeBerge:4]HB_ReferenceID:1>0)
	Process_Go2(-><>PR_HBST; "Go_HébergementSPPLUS"; "ST"; 32; [HeBerge:4]HB_ReferenceID:1; "N")
Else 
	StrAlerte(3; "")
End if 
