$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		MESSAGES ON:C181
		[DiaLogues:3]DL_Libellé:3:=va_CléClé
		If ([DiaLogues:3]DL_Libellé:3>"")
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=[DiaLogues:3]DL_Libellé:3)
			ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		Else 
			REDUCE SELECTION:C351([HeBerge:4]; 0)
		End if 
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		FIRST RECORD:C50([HeBerge:4])
		PREVIOUS RECORD:C110([HeBerge:4])
		MESSAGES OFF:C175
		vl_SourisXb:=0
		vl_SourisYb:=0
		vl_SourisBtb:=0
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisXb; vl_SourisYb; vl_SourisBtb)
		If ((vl_SourisXb>7) & (vl_SourisXb<330)) & ((vl_SourisYb>30) & (vl_SourisYb<318))
			If ([HeBerge:4]HB_ReferenceID:1>0)
				If ([HeBerge:4]HB_ReferenceID:1>0)
					vl_IDT_RéfU:=[HeBerge:4]HB_ReferenceID:1
					va_IDT_Old:=[HeBerge:4]HB_Clé:2
					va_IDT_Nom:=[HeBerge:4]HB_Nom:3
					va_IDT_Pré:=[HeBerge:4]HB_Prénom:4
					vd_IDT_NéLe:=[HeBerge:4]HB_DateNéLe:5
					vl_IDT_Stat:=Num:C11([HeBerge:4]HB_Status:18=True:C214)
					$vl_Fenetre:=i_FenêtreNo(352; 362; 5; "Modifier la clé"; 3; "Quit_Simple")
					DIALOG:C40([DiaLogues:3]; "DL_HébergéCléModifier")
					CLOSE WINDOW:C154($vl_Fenetre)
				Else 
					StrAlerte(2; "")
				End if 
				FIRST RECORD:C50([HeBerge:4])
				PREVIOUS RECORD:C110([HeBerge:4])
				
			End if 
		End if 
End case 