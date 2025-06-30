If ([HeBerge:4]HB_ReferenceID:1>0)
	va_IDT_Typ2:=[HeBerge:4]HB_Clé:2
	vl_IDT_Réf2:=[HeBerge:4]HB_ReferenceID:1
	If (va_IDT_Typ1>"") & (va_IDT_Typ2>"")
		OBJECT SET ENABLED:C1123(b_Fuse; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_Fuse; False:C215)
	End if 
Else 
	StrAlerte(22; "")
End if 