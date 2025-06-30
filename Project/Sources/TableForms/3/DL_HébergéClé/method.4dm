$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
		ve_IDT_Age:=Uut_HébergéAgePlus(->vd_IDT_NéLe; ->vd_Dt_Fich)
		rIDTG_1:=x_IDTG_1
		rIDTG_2:=x_IDTG_2
		
		If (ve_EtCvSaisissable>0)
			OBJECT SET ENTERABLE:C238(va_IDT_Nom; True:C214)
			OBJECT SET ENTERABLE:C238(va_IDT_Pré; True:C214)
			
			OBJECT SET ENTERABLE:C238(vd_IDT_NéLe; True:C214)
			
			OBJECT SET ENTERABLE:C238(x_IDTG_1; True:C214)
			OBJECT SET ENTERABLE:C238(x_IDTG_2; True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(va_IDT_Nom; False:C215)
			OBJECT SET ENTERABLE:C238(va_IDT_Pré; False:C215)
			
			OBJECT SET ENTERABLE:C238(vd_IDT_NéLe; False:C215)
			
			OBJECT SET ENTERABLE:C238(x_IDTG_1; False:C215)
			OBJECT SET ENTERABLE:C238(x_IDTG_2; False:C215)
		End if 
		
End case 