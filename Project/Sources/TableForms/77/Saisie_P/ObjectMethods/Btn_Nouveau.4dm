Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		READ WRITE:C146([NAV_Sous_Menus:78])
		ADD RECORD:C56([NAV_Sous_Menus:78])
		
		DIALOG:C40([NAV_Sous_Menus:78]; "Saisie_P")
		
		READ ONLY:C145([NAV_Sous_Menus:78])
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		
		order_max:=Records in selection:C76([NAV_Sous_Menus:78])+1
		
End case 