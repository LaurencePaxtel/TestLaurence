
$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		vPos1:=0
		vPos2:=0
		vPos2:=Length:C16([MemO:30]MO_Note:5)+1
		HIGHLIGHT TEXT:C210([MemO:30]MO_Note:5; vPos2; vPos2)
	: ($vl_eventFF=Sur appel extérieur:K2:11)
		If (<>vt_Trans#"")
			[MemO:30]MO_Note:5:=[MemO:30]MO_Note:5+<>va_CR+<>vt_Trans
		End if 
End case 
