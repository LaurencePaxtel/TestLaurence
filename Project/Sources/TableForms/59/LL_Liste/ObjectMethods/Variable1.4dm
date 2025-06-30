C_TIME:C306($h_RefDoc)
If (Records in selection:C76([LesLogs:59])>0)
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		i_Message("Export en cours …")
		FIRST RECORD:C50([LesLogs:59])
		Repeat 
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; Substring:C12([LesLogs:59]LL_DateHeure:2; 1; 8)+"-"+Substring:C12([LesLogs:59]LL_DateHeure:2; 9)+<>va_TAB+[LesLogs:59]LL_User:1+<>va_TAB+[LesLogs:59]LL_Type:3+<>va_TAB+[LesLogs:59]LL_FicheNo:4+Char:C90(13))
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Substring:C12([LesLogs:59]LL_DateHeure:2; 1; 8)+"-"+Substring:C12([LesLogs:59]LL_DateHeure:2; 9)+<>va_TAB+[LesLogs:59]LL_User:1+<>va_TAB+[LesLogs:59]LL_Type:3+<>va_TAB+[LesLogs:59]LL_FicheNo:4+Char:C90(13)))
			End if 
			NEXT RECORD:C51([LesLogs:59])
		Until (End selection:C36([LesLogs:59]))
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
		
		CLOSE WINDOW:C154
	End if 
	
Else 
	ALERT:C41("Acune donnée !")
End if 
