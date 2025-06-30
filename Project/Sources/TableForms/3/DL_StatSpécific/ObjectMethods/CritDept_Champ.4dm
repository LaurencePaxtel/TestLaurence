If (Form event code:C388=Sur données modifiées:K2:15)
	If (Length:C16(va_Dept)>2)
		va_Dept:=Substring:C12(va_Dept; 1; 2)
	End if 
	
End if 