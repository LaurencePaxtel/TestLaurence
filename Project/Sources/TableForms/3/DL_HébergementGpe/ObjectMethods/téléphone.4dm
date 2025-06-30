Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT SET FORMAT:C236(*; "telephone"; "##-##-##-##-##")
	: (Form event code:C388=Sur données modifiées:K2:15)
		Self:C308->:=Clean_phone_number(Self:C308->)
End case 