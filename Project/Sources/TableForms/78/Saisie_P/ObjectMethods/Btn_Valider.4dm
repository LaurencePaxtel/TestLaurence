
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Is new record:C668([NAV_Sous_Menus:78]))
			MultiSoc_Init_Structure(->[NAV_Sous_Menus:78])
		End if 
		
		[NAV_Sous_Menus:78]NS_ID_Menu:2:=[NAV_Menus:77]ID:1
		SAVE RECORD:C53([NAV_Sous_Menus:78])
		ACCEPT:C269
End case 
