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
If ([DossierSocial:25]DS_HB_ID:10>0)
	Process_Go2(-><>PR_HBSTV; "Go_HébergementSP"; "ST"; 32; [DossierSocial:25]DS_HB_ID:10; "V")
Else 
	StrAlerte(3; "")
End if 