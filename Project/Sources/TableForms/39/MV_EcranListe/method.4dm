$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur entête:K2:17)
		SET WINDOW TITLE:C213(vaTitreMes+" : "+String:C10(Records in selection:C76([MessagerieVSM:39])))
		If (Read only state:C362([MessagerieVSM:39]))
		Else 
			UNLOAD RECORD:C212([MessagerieVSM:39])
			READ ONLY:C145([MessagerieVSM:39])
		End if 
	: ($vl_EventFF=Sur affichage corps:K2:22)
		
	: ($vl_EventFF=Sur double clic:K2:5)
		If (Read only state:C362([MessagerieVSM:39]))
			READ WRITE:C146([MessagerieVSM:39])
		End if 
		
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		P_MessagerieVSM
		
End case 