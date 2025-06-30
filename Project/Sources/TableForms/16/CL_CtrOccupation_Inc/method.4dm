$evt_FFx:=Form event code:C388
Case of 
	: ($evt_FFx=Sur chargement:K2:1)
		//  CHOIX SAISISSABLE([CentresLits]CL_RestantsVeille;◊vb_CentreEXClits)
	: ($evt_FFx=Sur affichage corps:K2:22)
		
		OBJECT SET FONT STYLE:C166([LesCentres:9]LC_Nom:4; Num:C11([LesCentres:9]LC_Excuse:49))
End case 