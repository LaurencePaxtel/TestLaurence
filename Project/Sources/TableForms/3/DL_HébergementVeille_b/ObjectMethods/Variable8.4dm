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

LOAD RECORD:C52([HeberGement:5])
If ([HeberGement:5]HG_HB_ID:19>0)
	Process_Go2(-><>PR_HBSTV; "Go_HébergementSPPLUS"; "ST"; 32; [HeberGement:5]HG_HB_ID:19; "V")
Else 
	StrAlerte(3; "")
End if 