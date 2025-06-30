If (Form event code:C388=Sur chargement:K2:1)
	
	va_IDT_Titr:="Etat civil"
	//x_IDTG_1:=1
	//x_IDTG_2:=0
	If (x_IDTG_1=x_IDTG_2)
		x_IDTG_1:=1
		x_IDTG_2:=0
	End if 
	rIDTG_1:=x_IDTG_1
	rIDTG_2:=x_IDTG_2
	va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
	ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
	
End if 