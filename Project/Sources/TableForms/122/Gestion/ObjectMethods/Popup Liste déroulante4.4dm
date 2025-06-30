Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(selectResult_at; 0)
		
		outilsAddToArray(->selectResult_at; "10"; "25"; "50"; "Tous")
		selectResult_at:=1
	: (Form event code:C388=Sur données modifiées:K2:15)
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 