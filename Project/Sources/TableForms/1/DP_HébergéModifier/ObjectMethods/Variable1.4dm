//Script va_IDT_Nom
va_IDT_Nom:=Uppercase:C13(va_IDT_Nom)
If (va_IDT_Nom>"")
	Repeat 
		If (Character code:C91(va_IDT_Nom[[1]])<=32)
			va_IDT_Nom:=Substring:C12(va_IDT_Nom; 2)
		End if 
	Until (Character code:C91(va_IDT_Nom[[1]])>32)
End if 
va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)