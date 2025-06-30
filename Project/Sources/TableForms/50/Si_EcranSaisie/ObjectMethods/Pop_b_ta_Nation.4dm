If (vl_SP_Reference>0)
	C_TEXT:C284($va_Temp)
	$va_Temp:=va_SP_Nationalite
	
	
	If (F_Tab_Pop("Nationalité"; -><>ta_SIAO_Nationalite; ->va_SP_Nationalite))
		
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Nationalite:23); ->va_SP_Nationalite; ta_SP_Nom))
			If (va_SP_Nationalite>"")
				If ($va_Temp=va_SP_Nationalite)
				Else 
					
					If (<>vb_T_CtrlNation)
						If (va_SP_Nationalite[[1]]="*")
						Else 
							If (i_Confirmer("Vous devez obtenir une déclaration signée pour toute information relative à la nationalité dont le libellé n'est pas précédé  d'une *."+<>va_CR+<>va_CR+"Veuillez imprimer et faire signer la déclaration ou annuler le choix."))
								P_SIAO_AttestNation(1)
							Else 
								va_SP_Nationalite:=""
								If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Nationalite:23); ->va_SP_Nationalite; ta_SP_Nom))
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
		
		
	End if 
End if 

