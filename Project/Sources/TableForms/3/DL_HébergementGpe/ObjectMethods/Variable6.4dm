va_IDT_Pré:=Uppercase:C13(va_IDT_Pré)

If (Length:C16(va_IDT_Pré)>20)
	ALERT:C41("La longueur du prénom ne peut pas dépasser 20 caractères !")
	va_IDT_Pré:=Substring:C12(va_IDT_Pré; 1; 20)
End if 