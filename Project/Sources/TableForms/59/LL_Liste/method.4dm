C_LONGINT:C283($vl_Event)
$vl_event:=Form event code:C388
Case of 
	: ($vl_Event=Sur entête:K2:17)
		SET WINDOW TITLE:C213("Logs :  "+String:C10(Records in selection:C76([LesLogs:59]))+" parmi "+String:C10(Records in table:C83([LesLogs:59]))+"  - "+va_lesLogsDateHeure)
		
	: ($vl_Event=Sur chargement:K2:1)
	: ($vl_Event=Sur affichage corps:K2:22)
		OBJECT SET VISIBLE:C603(*; "Log_@"; False:C215)
		If ([LesLogs:59]LL_DateHeure:2>"")
			
			Case of 
				: ([LesLogs:59]LL_Type:3=<>va_Log_Entree)
					OBJECT SET VISIBLE:C603(*; "Log_Entree"; True:C214)
				: ([LesLogs:59]LL_Type:3=<>va_Log_Sortie)
					OBJECT SET VISIBLE:C603(*; "Log_Sortie"; True:C214)
				: ([LesLogs:59]LL_Type:3=<>va_Log_Hebergement)
					OBJECT SET VISIBLE:C603(*; "Log_HB"; True:C214)
				: ([LesLogs:59]LL_Type:3=<>va_Log_SIAO)
					OBJECT SET VISIBLE:C603(*; "Log_SIAO"; True:C214)
			End case 
		End if 
	: ($vl_Event=Sur double clic:K2:5)
		FILTER EVENT:C321
End case 
