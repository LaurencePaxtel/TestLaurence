$evt_FF:=Form event code:C388
Case of 
	: ($evt_FF=Sur chargement:K2:1)
		OBJECT SET ENTERABLE:C238([CentresLits:16]CL_RestantsVeille:16; <>vb_CentreEXClits)
	: ($evt_FF=Sur affichage corps:K2:22)
		OBJECT SET FONT STYLE:C166([LesCentres:9]LC_Nom:4; Num:C11([LesCentres:9]LC_Excuse:49))
End case 