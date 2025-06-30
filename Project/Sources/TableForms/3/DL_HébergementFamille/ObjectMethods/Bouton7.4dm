

If (va_LaFamilleN>"")
	MESSAGES ON:C181
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_LaFamilleN+"@"))
	MultiSoc_Filter(->[HeBerge:4])
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
	FIRST RECORD:C50([HeBerge:4])
	MESSAGES OFF:C175
	
End if 