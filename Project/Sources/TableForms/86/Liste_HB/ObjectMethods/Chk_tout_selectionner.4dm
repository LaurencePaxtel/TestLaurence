Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		C_LONGINT:C283($i)
		C_BOOLEAN:C305($value)
		
		If (Chk_tout_selectionner)
			$value:=True:C214
		Else 
			$value:=False:C215
		End if 
		
		For ($i; 1; Size of array:C274(tb_liste_choix))
			
			tb_liste_choix{$i}:=$value
			
		End for 
		
		REDRAW:C174(LB_Liste_HB)
		
End case 





