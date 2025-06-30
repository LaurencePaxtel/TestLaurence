Case of 
	: (Form event code:C388=Sur données modifiées:K2:15) | (Form event code:C388=Sur clic:K2:4)
		Form:C1466.paramImpression:=Form:C1466.entitySelection.query("valeur = :1"; Form:C1466.impression)[0].extraParam.detail
End case 