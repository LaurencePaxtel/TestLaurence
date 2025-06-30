Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		[NAV_Sous_Menus:78]NS_ID_Menu:2:=[NAV_Menus:77]ID:1
		
		If ([NAV_Sous_Menus:78]NS_Ordre:7=0)
			[NAV_Sous_Menus:78]NS_Ordre:7:=order_max+1
		End if 
		
End case 