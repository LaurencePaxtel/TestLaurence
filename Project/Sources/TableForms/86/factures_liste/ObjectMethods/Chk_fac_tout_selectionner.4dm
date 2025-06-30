C_LONGINT:C283($i)
C_BOOLEAN:C305($value)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$value:=Chk_fac_tout_selectionner
		
		For ($i; 1; Size of array:C274(tb_fac_choix))
			tb_fac_choix{$i}:=$value
		End for 
		
		REDRAW:C174(LB_Liste_factures)
End case 