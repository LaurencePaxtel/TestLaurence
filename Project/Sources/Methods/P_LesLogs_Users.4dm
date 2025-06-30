//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_LesLogs_Users
//{          Mercredi 13 avril 2011 à 12:46
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
ALL RECORDS:C47([LesLogs:59])
MultiSoc_Filter(->[LesLogs:59])
DISTINCT VALUES:C339([LesLogs:59]LL_User:1; ta_LesLogs_User)
INSERT IN ARRAY:C227(ta_LesLogs_User; 1; 1)
ta_LesLogs_User{1}:="Tous"
If (Size of array:C274(ta_LesLogs_User)>1)
	INSERT IN ARRAY:C227(ta_LesLogs_User; 2; 1)
	ta_LesLogs_User{2}:="-"
End if 
va_lesLogsDateHeure:=" le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178; h mn:K7:2)
ta_LesLogs_User:=1