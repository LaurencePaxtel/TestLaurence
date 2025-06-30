//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{          Procédure : P_LesLogs  
//{          Mercredi 13 avril 2011 à 11:22:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_TEXT:C284($2)


If (<>vb_T_LogActif)
	If (Not:C34(User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN)))
		READ WRITE:C146([LesLogs:59])
		CREATE RECORD:C68([LesLogs:59])
		MultiSoc_Init_Structure(->[LesLogs:59])
		[LesLogs:59]LL_Type:3:=$1
		[LesLogs:59]LL_User:1:=Current user:C182
		[LesLogs:59]LL_FicheNo:4:=$2
		[LesLogs:59]LL_DateHeure:2:=F_DateHeureAlphaInversé(Current date:C33; Current time:C178)
		SAVE RECORD:C53([LesLogs:59])
		UNLOAD RECORD:C212([LesLogs:59])
		READ ONLY:C145([LesLogs:59])
	End if 
End if 
