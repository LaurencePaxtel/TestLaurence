//Script b_ModCléHG
If ([HeBerge:4]HB_ReferenceID:1>0)
	C_LONGINT:C283(vl_IDT_RéfU)
	C_TEXT:C284(va_IDT_Nom)
	C_TEXT:C284(va_IDT_Pré)
	C_DATE:C307(vd_IDT_NéLe)
	C_TEXT:C284(va_IDT_Old)
	C_TEXT:C284(va_IDT_Clé)
	C_LONGINT:C283(vl_IDT_Stat)
	vl_IDT_RéfU:=[HeBerge:4]HB_ReferenceID:1
	va_IDT_Old:=[HeBerge:4]HB_Clé:2
	va_IDT_Nom:=[HeBerge:4]HB_Nom:3
	va_IDT_Pré:=[HeBerge:4]HB_Prénom:4
	vd_IDT_NéLe:=[HeBerge:4]HB_DateNéLe:5
	vl_IDT_Stat:=Num:C11([HeBerge:4]HB_Status:18=True:C214)
	
	P_HébergéModifier(va_IDT_Old)
Else 
	StrAlerte(22; "")
End if 
FIRST RECORD:C50([HeBerge:4])
PREVIOUS RECORD:C110([HeBerge:4])