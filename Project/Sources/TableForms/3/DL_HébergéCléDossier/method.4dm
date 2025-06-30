$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		va_IDT_Titr:="Nouvelle fiche : Etat Civil"
		va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
		ve_IDT_Age:=Uut_HébergéAgePlus(->vd_IDT_NéLe; ->vd_Dt_Fich)
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		rIDTG_1:=x_IDTG_1
		rIDTG_2:=x_IDTG_2
End case 