C_LONGINT:C283($Position)

If ([TypesTables:11]TT_Libellé:4>"")
	$Position:=Find in array:C230(ta_TTStrLib; [TypesTables:11]TT_Libellé:4)
	
	If ($Position>0)
		[TypesTables:11]TT_Libellé:4:=ta_TTStrLib{$Position}
		
		If (tl_TTStrCas{$Position}=1)
			[TypesTables:11]TT_RéférenceID:1:=tl_TTStrRéf{$Position}
		End if 
		
	Else 
		ALERT:C41("L'énumération : "+[TypesTables:11]TT_Libellé:4+<>va_CR+<>va_CR+"n'est pas référencé !")
	End if 
	
End if 