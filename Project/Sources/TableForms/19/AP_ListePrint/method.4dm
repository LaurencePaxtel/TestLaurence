$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur impression corps:K2:18)
		ve_JouN:=Num:C11([APpels:19]AP_Nuit:4)
	: ($vl_EventFF=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 