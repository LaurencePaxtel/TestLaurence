$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		vt_TempActi:=""
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		CANCEL:C270
End case 
