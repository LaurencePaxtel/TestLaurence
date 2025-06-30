
vl_EventFF:=Form event code:C388
Case of 
	: (vl_EventFF=Sur chargement:K2:1)
		//vt_CurrentURL:=""
		SET TIMER:C645(60)
		SET WINDOW TITLE:C213("Logalisation GPS")
		//vl_Error:=Web_SetURL (myBrowser;◊vt_LienGPS;0)
		
	: (vl_EventFF=Sur minuteur:K2:25)
		SET TIMER:C645(0)
		// vl_Error:=Web_GetURL(myBrowser;vt_CurrentURL)
		SET TIMER:C645(30)
End case 