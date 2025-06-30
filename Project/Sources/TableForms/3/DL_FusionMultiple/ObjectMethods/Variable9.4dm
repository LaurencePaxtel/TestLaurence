//Script b_SupCléHG
If (Size of array:C274(tl_Fu_Référence)>0)
	If (ta_FU_Clé>0)
		CREATE SET:C116([HeBerge:4]; "E_HBliste")
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=tl_Fu_Référence{ta_FU_Clé})
		MultiSoc_Filter(->[HeberGement:5])
		vL_Nb_HB_F:=Records in selection:C76([HeberGement:5])
		If (vL_Nb_HB_F>0)
			CREATE SET:C116([HeberGement:5]; "E_SHGClé")
		End if 
		
		CONFIRM:C162(ta_FU_Clé{ta_FU_Clé}+Char:C90(13)+(("+ "+String:C10(vL_Nb_HB_F)+" fiche(s) d'hébergement")*Num:C11(vL_Nb_HB_F>0))+Char:C90(13)+"Confirmez-vous la suppression ?")
		If (OK=1)
			i_Message("Suppression en cours …")
			READ WRITE:C146([HeBerge:4])
			If (i_NonVerrou(->[HeBerge:4]))
				If (vL_Nb_HB_F>0)
					READ WRITE:C146([HeberGement:5])
					READ WRITE:C146([FicheMedicaleOl:6])
					READ WRITE:C146([LeMedical:7])
					READ WRITE:C146([LeSignaletique:8])
					USE SET:C118("E_SHGClé")
					RELATE MANY SELECTION:C340([LeSignaletique:8]LS_HB_ID:2)
					If (Records in selection:C76([LeSignaletique:8])>0)
						DELETE SELECTION:C66([LeSignaletique:8])
					End if 
					USE SET:C118("E_SHGClé")
					RELATE MANY SELECTION:C340([HebergementLie:15]HL_HG_ID:1)
					If (Records in selection:C76([HebergementLie:15])>0)
						DELETE SELECTION:C66([HebergementLie:15])
					End if 
					USE SET:C118("E_SHGClé")
					FIRST RECORD:C50([HeberGement:5])
					While (Not:C34(End selection:C36([HeberGement:5])))
						If ([HeberGement:5]HG_Cloturée:67)
							If ([HeberGement:5]HG_LC_ID:61>0)
								If ([HeberGement:5]HG_Nuit:2)
									P_CL_LitsAffecter([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; -1; "N")
								Else 
									P_CL_LitsAffecter([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; -1; "J")
								End if 
							End if 
						End if 
						QUERY:C277([FicheMedicaleOl:6]; [FicheMedicaleOl:6]FM_FicheNuméro:5=[HeberGement:5]HG_FicheNuméro:3)
						MultiSoc_Filter(->[FicheMedicaleOl:6])
						If (Records in selection:C76([FicheMedicaleOl:6])>0)
							RELATE MANY SELECTION:C340([LeMedical:7]LM_FM_ID:2)
							If (Records in selection:C76([LeMedical:7])>0)
								DELETE SELECTION:C66([LeMedical:7])
							End if 
						End if 
						QUERY:C277([FicheMedicaleOl:6]; [FicheMedicaleOl:6]FM_FicheNuméro:5=[HeberGement:5]HG_FicheNuméro:3)
						MultiSoc_Filter(->[FicheMedicaleOl:6])
						DELETE SELECTION:C66([FicheMedicaleOl:6])
						
						NEXT RECORD:C51([HeberGement:5])
					End while 
					USE SET:C118("E_SHGClé")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Facture:172=False:C215)
					DELETE SELECTION:C66([HeberGement:5])
					READ ONLY:C145([HeberGement:5])
					READ ONLY:C145([FicheMedicaleOl:6])
					READ ONLY:C145([LeMedical:7])
					READ ONLY:C145([LeSignaletique:8])
				End if 
				
				DELETE RECORD:C58([HeBerge:4])
				READ ONLY:C145([HeBerge:4])
				Tab_Fusion(3; ta_FU_Clé; 0)
				
				CLOSE WINDOW:C154
			Else 
				UNLOAD RECORD:C212([HeBerge:4])
			End if 
		End if 
		
		If (vL_Nb_HB_F>0)
			CLEAR SET:C117("E_SHGClé")
		End if 
		
		USE SET:C118("E_HBliste")
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		FIRST RECORD:C50([HeBerge:4])
		PREVIOUS RECORD:C110([HeBerge:4])
		CLEAR SET:C117("E_HBliste")
		
	Else 
		StrAlerte(22; "")
	End if 
End if 

REDRAW:C174([HeBerge:4])
