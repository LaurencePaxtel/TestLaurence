$evt_FF:=Form event code:C388
Case of 
	: ($evt_FF=Sur impression corps:K2:18)
		OBJECT SET FONT STYLE:C166([LesCentres:9]LC_Nom:4; Num:C11([LesCentres:9]LC_Excuse:49))
	: ($evt_FF=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 