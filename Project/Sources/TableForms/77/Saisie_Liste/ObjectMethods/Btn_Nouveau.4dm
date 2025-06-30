Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		READ WRITE:C146([NAV_Menus:77])
		ADD RECORD:C56([NAV_Menus:77])
		
		DIALOG:C40([NAV_Menus:77]; "Saisie_P")
		
		READ ONLY:C145([NAV_Menus:77])
		ALL RECORDS:C47([NAV_Menus:77])
		MultiSoc_Filter(->[NAV_Menus:77])
End case 


