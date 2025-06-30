$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur affichage corps:K2:22)
		ve_Genre:=Num:C11([MemO:30]MO_Nuit:4)
		
	: ($vl_EventFF=Sur double clic:K2:5)
		FILTER EVENT:C321
End case 