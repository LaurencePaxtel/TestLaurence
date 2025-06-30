If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(te_CCE_Check)>0)
		If (te_CCE_Check{1}>0)
			If (i_Confirmer("Désélectionner tous les centres ?"))
				For ($ii; 1; Size of array:C274(te_CCE_Check))
					te_CCE_Check{$ii}:=0
				End for 
				
				va_CCE_Nom:=String:C10(vl_TT)+" dont : 0 sélectionné(s)"
				
			End if 
		Else 
			If (i_Confirmer("Sélectionner tous les centres ?"))
				For ($ii; 1; Size of array:C274(te_CCE_Check))
					te_CCE_Check{$ii}:=1
				End for 
				
				va_CCE_Nom:=String:C10(vl_TT)+" dont : "+String:C10(vl_TT)+" sélectionné(s)"
				
			End if 
		End if 
	End if 
End if 