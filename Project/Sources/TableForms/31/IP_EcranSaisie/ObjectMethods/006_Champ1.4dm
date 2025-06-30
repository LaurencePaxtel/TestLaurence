If ([IntervenantsProfils:31]IP_Type:2>0) & ([IntervenantsProfils:31]IP_Type:2<10)
	va_Type:=Substring:C12(<>ta_Types{[IntervenantsProfils:31]IP_Type:2}; 5)
Else 
	va_Type:=""
End if 