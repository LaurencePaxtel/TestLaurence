//vl_RéfU_HBB
If (Form event code:C388=Sur clic:K2:4)
	
	If (b_ValHBnew=1)  // Click sur le bouton NOUVEL HEBERGEMENT
		vb_ResGroupe:=False:C215
		vb_ResMulti:=False:C215
		vb_PasseR:=True:C214
		
		If (wresMulti=1)  // Réservation multiple
			vl_NbBoucle:=Size of array:C274(<>ta_FamilleClé)
			
			If (vl_NbBoucle>0)
				vb_ResMulti:=True:C214
			Else 
				vb_PasseR:=False:C215
				StrAlerte(16; "")
			End if 
			
		Else 
			vl_NbBoucle:=1
			
			If ([HeBerge:4]HB_ReferenceID:1>0)
				<>vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
				vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
				
				Tab_PopIn1n("Type"; -><>ta_TBEtCiv; ->va_IDT_Typ1)
				
				If (va_IDT_Typ1>"")
					
					If (Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-2; 1)="F")
						rIDTG_1:=0
						rIDTG_2:=1
					Else 
						rIDTG_1:=1
						rIDTG_2:=0
					End if 
					
					x_IDTG_1:=rIDTG_1
					x_IDTG_2:=rIDTG_2
					
					If (F_HébergementCtrlCréation(va_JourNuit))
						
						If (vl_NbHéberGements>0)  // V_IDT_Déc (2)  `Dupliquer
							F_VariablesTransite(2; 1; False:C215)
						Else 
							F_VariablesTransite(3; 1; False:C215)
						End if 
						
						x_IDTG_1:=rIDTG_1
						x_IDTG_2:=rIDTG_2
					Else 
						vb_PasseR:=False:C215
					End if 
					
				Else 
					vb_PasseR:=False:C215
				End if 
				
			Else 
				StrAlerte(3; "")
				vb_PasseR:=False:C215
			End if 
			
		End if 
		
		If (vb_PasseR)
			CANCEL:C270
		End if 
		
	Else 
		vb_PasseR:=False:C215
	End if 
	
End if 