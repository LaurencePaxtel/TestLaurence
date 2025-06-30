$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur affichage corps:K2:22)
		va_TypeLibellé:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
	: ($vl_EventFF=Sur double clic:K2:5)
		FILTER EVENT:C321
End case 