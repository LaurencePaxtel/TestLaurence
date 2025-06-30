If (Form event code:C388=Sur données modifiées:K2:15)
	If (va_IDT_LienFam>"")
		MESSAGES ON:C181
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FamClé:104=va_IDT_LienFam)
		MultiSoc_Filter(->[HeberGement:5])
		RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
		MultiSoc_Filter(->[HeBerge:4])
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		FIRST RECORD:C50([HeBerge:4])
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		vL_Nb_HG_F:=0
		va_NNN:=""
		P_HébergementNotesBt(0)
		If (wresMulti=0)
			OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
		End if 
		MESSAGES OFF:C175
	End if 
End if 