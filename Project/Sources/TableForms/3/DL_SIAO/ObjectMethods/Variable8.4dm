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
If ([SIAO:50]Si_Demandeur_ID:21>0)
	If (7=8)
		Process_Go2(-><>PR_HBSTV; "Go_HébergementSPPLUS"; "ST"; 32; [HeberGement:5]HG_HB_ID:19; "V")
	End if 
	ALERT:C41("Développement en cours…")
Else 
	StrAlerte(3; "")
End if 