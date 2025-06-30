If (Form event code:C388=Sur données modifiées:K2:15)
	$ve:=0
	$ve:=Character code:C91("@")
	va_MPmot1:=Replace string:C233(va_MPmot1; Char:C90($ve); "")
	
End if 