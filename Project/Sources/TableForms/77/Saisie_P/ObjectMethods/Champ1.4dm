If ([NAV_Menus:77]NP_Menu_Libelle:2="")
	OBJECT SET ENTERABLE:C238([NAV_Menus:77]NP_Menu_Libelle:2; True:C214)
Else 
	OBJECT SET ENTERABLE:C238([NAV_Menus:77]NP_Menu_Libelle:2; False:C215)
End if 