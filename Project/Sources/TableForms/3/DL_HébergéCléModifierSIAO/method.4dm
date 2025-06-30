If (Form event code:C388=Sur chargement:K2:1)
	// r_IDT_Statu:=vl_IDT_Stat
	ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
	va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
End if 