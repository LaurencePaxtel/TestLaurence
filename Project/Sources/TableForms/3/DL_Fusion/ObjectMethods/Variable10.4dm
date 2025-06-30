If (va_IDT_Typ1>"")
	If (va_IDT_Typ2>"")
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_IDT_Réf1)
		MultiSoc_Filter(->[HeBerge:4])
		If (Records in selection:C76([HeBerge:4])=1)
			
			va_FusNom:=[HeBerge:4]HB_Nom:3
			va_FusPré:=[HeBerge:4]HB_Prénom:4
			vd_FusNé:=[HeBerge:4]HB_DateNéLe:5
			vb_FusSex:=[HeBerge:4]HG_Genre:39
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_IDT_Réf2)
			MultiSoc_Filter(->[HeBerge:4])
			If (Records in selection:C76([HeBerge:4])=1)
				
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_IDT_Réf2)
				MultiSoc_Filter(->[HeberGement:5])
				
				If (i_Confirmer("Fusionner :"+va_IDT_Typ2+" vers :"+va_IDT_Typ1))
					i_Message("Fusion en cours …")
					READ WRITE:C146([HeberGement:5])
					FIRST RECORD:C50([HeberGement:5])
					APPLY TO SELECTION:C70([HeberGement:5]; P_Fusion)
					UNLOAD RECORD:C212([HeberGement:5])
					READ ONLY:C145([HeberGement:5])
					READ WRITE:C146([HeBerge:4])
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_IDT_Réf2)
					MultiSoc_Filter(->[HeBerge:4])
					If (Records in selection:C76([HeBerge:4])>0)
						DELETE SELECTION:C66([HeBerge:4])
					End if 
					READ ONLY:C145([HeBerge:4])
					
					If ([DiaLogues:3]DL_LibelAutre:5>"")
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=([DiaLogues:3]DL_LibelAutre:5+"@"))
						MultiSoc_Filter(->[HeBerge:4])
						ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
					Else 
						REDUCE SELECTION:C351([HeBerge:4]; 0)
					End if 
					FIRST RECORD:C50([HeBerge:4])
					PREVIOUS RECORD:C110([HeBerge:4])
					vl_itemNb:=Records in selection:C76([HeBerge:4])
					CLOSE WINDOW:C154
				End if 
			Else 
				ALERT:C41("Fiche Clé à fusionner non trouvée !")
			End if 
		Else 
			ALERT:C41("Fiche Clé non trouvée !")
		End if 
	Else 
		ALERT:C41("Vous devez vous selectionner la clé à fusionner !")
	End if 
Else 
	ALERT:C41("Vous devez vous selectionner la clé !")
End if 