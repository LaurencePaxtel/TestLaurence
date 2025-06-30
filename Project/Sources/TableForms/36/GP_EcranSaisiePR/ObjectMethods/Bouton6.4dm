//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_RPtri 
//{          Vendredi 17 septembre 2004 à 15:23:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


If (Form event code:C388=Sur clic:K2:4)
	ORDER BY:C49([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6; <)
	FIRST RECORD:C50([Prolongation:38])
End if 