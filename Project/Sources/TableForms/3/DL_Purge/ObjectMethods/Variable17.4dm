
If (va_SupCP>"")
	i_Message("Recherche en cours …")
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_CodePostal:14=va_SupCP)
	MultiSoc_Filter(->[HeberGement:5])
	If (Records in selection:C76([HeberGement:5])>0)
		CLOSE WINDOW:C154
		CREATE SET:C116([HeberGement:5]; "E_SupEncours")
		CONFIRM:C162("Il ya "+String:C10(Records in selection:C76([HeberGement:5]))+" fiches d'hébergement."+Char:C90(13)+"Confirmez-vous la suppression ?")
		If (OK=1)
			i_Message("Suppression en cours …")
			READ WRITE:C146([HeberGement:5])
			READ WRITE:C146([FicheMedicaleOl:6])
			READ WRITE:C146([LeMedical:7])
			READ WRITE:C146([LeSignaletique:8])
			READ WRITE:C146([HebergementLie:15])
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
					DELETE SELECTION:C66([FicheMedicaleOl:6])
				End if 
				
				NEXT RECORD:C51([HeberGement:5])
			End while 
			USE SET:C118("E_SupEncours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Facture:172=False:C215)
			MultiSoc_Filter(->[HeberGement:5])
			DELETE SELECTION:C66([HeberGement:5])
			
			READ ONLY:C145([HeberGement:5])
			READ ONLY:C145([FicheMedicaleOl:6])
			READ ONLY:C145([LeMedical:7])
			READ ONLY:C145([LeSignaletique:8])
			READ ONLY:C145([HebergementLie:15])
			CLOSE WINDOW:C154
			
		End if 
	Else 
		CLOSE WINDOW:C154
		ALERT:C41("Aucune fiche trouvée !")
	End if 
	
Else 
	ALERT:C41("Le code postal est à blanc !")
End if 