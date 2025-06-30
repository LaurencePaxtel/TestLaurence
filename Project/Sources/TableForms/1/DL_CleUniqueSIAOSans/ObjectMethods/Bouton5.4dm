C_LONGINT:C283($vl_NbFiches)

Case of 
	: (va_IDT_Nom<="")
		StrAlerte(31; "")
		//REFUSER
	: (va_IDT_Pré="")
		StrAlerte(32; "")
		//REFUSER
	: (vd_IDT_NéLe=!00-00-00!)
		StrAlerte(33; "")
		//REFUSER
		// : (va_IDT_Typ1="")
		//  StrAlerte (30;"")
		//`REFUSER    
	Else 
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe))
		$vl_NbFiches:=Records in selection:C76([HeBerge:4])
		Case of 
			: ($vl_NbFiches>1)
				StrAlerte(11; Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe))
				//REFUSER
				
			: ($vl_NbFiches=0)
				vl_RéfU_HBB:=0
				READ WRITE:C146([HeBerge:4])
				CREATE RECORD:C68([HeBerge:4])
				[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
				
				[HeBerge:4]HB_Clé:2:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
				[HeBerge:4]HB_Nom:3:=va_IDT_Nom
				[HeBerge:4]HB_Prénom:4:=va_IDT_Pré
				[HeBerge:4]HB_DateNéLe:5:=vd_IDT_NéLe
				
				P_TypeEtCv_Genre(va_IDT_Typ1; ->x_IDTG_1; ->x_IDTG_2)
				
				[HeBerge:4]HG_Genre:39:=(x_IDTG_2=1)
				
				[HeBerge:4]HB_FicheCrééele:46:=Current date:C33(*)
				vl_Sel_CleUnique:=[HeBerge:4]HB_ReferenceID:1
				SAVE RECORD:C53([HeBerge:4])
				UNLOAD RECORD:C212([HeBerge:4])
				READ ONLY:C145([HeBerge:4])
				vb_Sel_CleUnique:=True:C214
				vb_Sel_CleNew:=True:C214
				CANCEL:C270
				
			: ($vl_NbFiches=1)
				vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
				StrAlerte(11; Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe))
				
		End case 
End case 