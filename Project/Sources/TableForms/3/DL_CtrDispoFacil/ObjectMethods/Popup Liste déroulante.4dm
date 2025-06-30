Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_LONGINT:C283($i_el)
		
		ARRAY TEXT:C222(litRestant_at; 0)
		
		For ($i_el; 0; 100)
			APPEND TO ARRAY:C911(litRestant_at; String:C10($i_el))
		End for 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_Restant:7>=Num:C11(litRestant_at{litRestant_at}))
End case 