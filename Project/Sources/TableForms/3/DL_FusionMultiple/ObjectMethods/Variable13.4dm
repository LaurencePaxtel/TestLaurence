//Script b_ModCléHG

If (Size of array:C274(tl_Fu_Référence)>0)
	If (ta_FU_Clé>0)
		CREATE SET:C116([HeBerge:4]; "E_HBliste")
		C_LONGINT:C283(vl_IDT_RéfU)
		C_TEXT:C284(va_IDT_Nom)
		C_TEXT:C284(va_IDT_Pré)
		C_DATE:C307(vd_IDT_NéLe)
		C_TEXT:C284(va_IDT_Old)
		C_TEXT:C284(va_IDT_Clé)
		C_LONGINT:C283(vl_IDT_Stat)
		
		Tab_Fusion(4; ta_FU_Clé; 0)
		b_ValET:=0
		P_HébergéModifier(va_IDT_Old)
		If (b_ValET=1)
			Tab_Fusion(5; ta_FU_Clé; 0)
		End if 
		
		USE SET:C118("E_HBliste")
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		FIRST RECORD:C50([HeBerge:4])
		PREVIOUS RECORD:C110([HeBerge:4])
		CLEAR SET:C117("E_HBliste")
	Else 
		StrAlerte(22; "")
	End if 
End if 
FIRST RECORD:C50([HeBerge:4])
PREVIOUS RECORD:C110([HeBerge:4])