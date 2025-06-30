If (va_NoF1>"") & (va_NoF2>"")
	i_Message("Recherche en cours …")
	
	If (va_NoF2<=va_NoF1)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=va_NoF1)
	End if 
	
	If (va_NoF2>va_NoF1)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3>=va_NoF1; *)
		QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_FicheNuméro:3<=va_NoF2)
	End if 
	
	MultiSoc_Filter(->[HeberGement:5])
	CLOSE WINDOW:C154
	
	If (Records in selection:C76([HeberGement:5])>0)
		CREATE SET:C116([HeberGement:5]; "E_SupEncours")
		CONFIRM:C162("Il y a "+String:C10(Records in selection:C76([HeberGement:5]))+" fiches d'hébergement."+Char:C90(13)+"Confirmez-vous la suppression ?")
		
		If (OK=1)
			i_Message("Suppression en cours …")
			
			READ WRITE:C146([HeBerge:4])
			READ WRITE:C146([HeberGement:5])
			READ WRITE:C146([FicheMedicaleOl:6])
			READ WRITE:C146([LeMedical:7])
			READ WRITE:C146([LeSignaletique:8])
			READ WRITE:C146([HebergementLie:15])
			READ WRITE:C146([CentresLits:16])
			
			USE SET:C118("E_SupEncours")
			RELATE MANY SELECTION:C340([LeSignaletique:8]LS_HB_ID:2)
			
			If (Records in selection:C76([LeSignaletique:8])>0)
				DELETE SELECTION:C66([LeSignaletique:8])
			End if 
			
			USE SET:C118("E_SupEncours")
			RELATE MANY SELECTION:C340([HebergementLie:15]HL_HG_ID:1)
			
			If (Records in selection:C76([HebergementLie:15])>0)
				DELETE SELECTION:C66([HebergementLie:15])
			End if 
			
			USE SET:C118("E_SupEncours")
			FIRST RECORD:C50([HeberGement:5])
			
			While (Not:C34(End selection:C36([HeberGement:5])))
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
			
			USE SET:C118("E_SupEncours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Facture:172=False:C215)
			
			DELETE SELECTION:C66([HeberGement:5])
			
			If (vd_DtFin<=vd_DtDéb)
				QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=vd_DtDéb)
				MultiSoc_Filter(->[CentresLits:16])
			End if 
			
			If (vd_DtFin>vd_DtDéb)
				QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3>=vd_DtDéb; *)
				QUERY:C277([CentresLits:16];  & [CentresLits:16]CL_Date:3<=vd_DtFin)
				MultiSoc_Filter(->[CentresLits:16])
			End if 
			
			If (Records in selection:C76([CentresLits:16])>0)
				APPLY TO SELECTION:C70([CentresLits:16]; [CentresLits:16]CL_Distribué:6:=0)
				APPLY TO SELECTION:C70([CentresLits:16]; [CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_DispoTotal:5)
			End if 
			
			READ ONLY:C145([HeBerge:4])
			READ ONLY:C145([HeberGement:5])
			READ ONLY:C145([FicheMedicaleOl:6])
			READ ONLY:C145([LeMedical:7])
			READ ONLY:C145([LeSignaletique:8])
			READ ONLY:C145([HebergementLie:15])
			READ ONLY:C145([CentresLits:16])
			
			CLOSE WINDOW:C154
		End if 
		
	Else 
		ALERT:C41("Aucune fiche trouvée !")
	End if 
	
Else 
	ALERT:C41("Vous devez saisir les n° de fiches !")
End if 