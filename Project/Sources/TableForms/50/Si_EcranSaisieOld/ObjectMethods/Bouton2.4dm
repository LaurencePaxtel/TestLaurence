C_LONGINT:C283($ii)
If (Size of array:C274(ta_SP_Nom)>0)
	
	If (ta_SP_Nom>0)
		If (ta_SP_SousTheme{ta_SP_Nom}=ta_SIAO_PopSitFamCode{3})
			$ii:=-1
		Else 
			$ii:=Find in array:C230(ta_SP_SousTheme; ta_SIAO_PopSitFamCode{3})
		End if 
	Else 
		$ii:=Find in array:C230(ta_SP_SousTheme; ta_SIAO_PopSitFamCode{3})
	End if 
	If ($ii>0)
		ta_SP_Nom:=$ii
		P_SIAO_PEClick(->ta_SP_Nom)
	End if 
End if 
