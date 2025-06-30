$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		P_UserFFsaisie(Sur chargement:K2:1)
	: ($vl_EventFF=Sur données modifiées:K2:15)
		P_UserFFsaisie(Sur données modifiées:K2:15)
End case 