If (vl_SP_Reference>0)
	If (F_Tab_Pop("Etat civil"; -><>ta_SIAO_EtCiv; ->va_SP_EtatCivil))
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_EtatCivil:8); ->va_SP_EtatCivil; ta_SP_Nom))
			
			If (va_SP_EtatCivil>"")
				If (Position:C15("("; va_SP_EtatCivil)>0)
					vb_SP_Genre:=(va_SP_EtatCivil[[Position:C15("("; va_SP_EtatCivil)+1]]="F")
					vL_SP_Genre1:=Num:C11(vb_SP_Genre=False:C215)
					vL_SP_Genre2:=Num:C11(vb_SP_Genre=True:C214)
					If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Genre:10); ->vb_SP_Genre; ta_SP_Nom))
					End if 
				End if 
			End if 
		End if 
	End if 
End if 