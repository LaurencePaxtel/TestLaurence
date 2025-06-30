

If (va_LaFamille>"")
	MESSAGES ON:C181
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FamClé:104=va_LaFamille)
	MultiSoc_Filter(->[HeberGement:5])
	RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
	MultiSoc_Filter(->[HeBerge:4])
	
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
	FIRST RECORD:C50([HeBerge:4])
	MESSAGES OFF:C175
	
End if 