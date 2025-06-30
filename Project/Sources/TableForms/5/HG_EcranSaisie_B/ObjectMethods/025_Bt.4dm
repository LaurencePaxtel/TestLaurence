C_TEXT:C284($va_Temp)
$va_Temp:=[HeberGement:5]HG_Nationalité:25

Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12}; -><>ta_TBNatio; ->[HeberGement:5]HG_Nationalité:25)

If ([HeberGement:5]HG_Nationalité:25>"")
	
	If ($va_Temp#[HeberGement:5]HG_Nationalité:25)
		
		If (<>vb_T_CtrlNation)
			
			If ([HeberGement:5]HG_Nationalité:25[[1]]#"*")
				
				If (i_Confirmer("Vous devez obtenir une déclaration signée "+"pour toute information relative à la nationalité (non précédée d'une *)."+<>va_CR+"Veuillez imprimer et faire signer la déclaration."))
					P_SIAO_AttestNation(0)
				Else 
					[HeberGement:5]HG_Nationalité:25:=""
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 