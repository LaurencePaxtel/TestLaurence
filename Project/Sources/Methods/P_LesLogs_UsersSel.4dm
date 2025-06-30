//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_LesLogs_UsersSel
//{          Mercredi 13 avril 2011 à 12:46
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Size of array:C274(ta_LesLogs_User)>0)
	Case of 
		: (ta_LesLogs_User=1)
			ALL RECORDS:C47([LesLogs:59])
			MultiSoc_Filter(->[LesLogs:59])
			ORDER BY:C49([LesLogs:59]; [LesLogs:59]LL_DateHeure:2; <)
		: (ta_LesLogs_User>2)
			QUERY:C277([LesLogs:59]; [LesLogs:59]LL_User:1=ta_LesLogs_User{ta_LesLogs_User})
			MultiSoc_Filter(->[LesLogs:59])
			ORDER BY:C49([LesLogs:59]; [LesLogs:59]LL_DateHeure:2; <)
	End case 
End if 