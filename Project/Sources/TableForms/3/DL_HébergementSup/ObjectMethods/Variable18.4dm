If (Form event code:C388=Sur clic:K2:4)
	READ WRITE:C146([HeberGement:5])
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=va_MPmot1)
	MultiSoc_Filter(->[HeberGement:5])
	If (Records in selection:C76([HeberGement:5])=1)
		If ([HeberGement:5]HG_Cloturée:67)
			ALERT:C41("La fiche n° : "+va_MPmot1+"  est clôturée !")
		Else 
			CONFIRM:C162("La fiche n° : "+va_MPmot1+Char:C90(13)+"Confirmez-vous la suppression ?")
			If (OK=1)
				If (i_NonVerrou(->[HeberGement:5]))
					i_Message("Suppression en cours …")
					READ WRITE:C146([LeSignaletique:8])
					QUERY:C277([LeSignaletique:8]; [LeSignaletique:8]LS_HB_ID:2=[HeberGement:5]HG_ReferenceID:1)
					MultiSoc_Filter(->[LeSignaletique:8])
					If (Records in selection:C76([LeSignaletique:8])>0)
						DELETE SELECTION:C66([LeSignaletique:8])
					End if 
					READ ONLY:C145([LeSignaletique:8])
					READ WRITE:C146([HebergementLie:15])
					QUERY:C277([HebergementLie:15]; [HebergementLie:15]HL_HG_ID:1=[HeberGement:5]HG_ReferenceID:1)
					MultiSoc_Filter(->[HebergementLie:15])
					If (Records in selection:C76([HebergementLie:15])>0)
						DELETE SELECTION:C66([HebergementLie:15])
					End if 
					READ ONLY:C145([HebergementLie:15])
					READ WRITE:C146([FicheMedicaleOl:6])
					READ WRITE:C146([LeMedical:7])
					QUERY:C277([FicheMedicaleOl:6]; [FicheMedicaleOl:6]FM_FicheNuméro:5=[HeberGement:5]HG_FicheNuméro:3)
					MultiSoc_Filter(->[FicheMedicaleOl:6])
					If (Records in selection:C76([FicheMedicaleOl:6])>0)
						RELATE MANY SELECTION:C340([LeMedical:7]LM_FM_ID:2)
						If (Records in selection:C76([LeMedical:7])>0)
							DELETE SELECTION:C66([LeMedical:7])
						End if 
						DELETE SELECTION:C66([FicheMedicaleOl:6])
					End if 
					READ ONLY:C145([LeMedical:7])
					READ ONLY:C145([FicheMedicaleOl:6])
					DELETE RECORD:C58([HeberGement:5])
					CLOSE WINDOW:C154
				End if 
			Else 
				UNLOAD RECORD:C212([HeberGement:5])
			End if 
		End if 
	End if 
	READ ONLY:C145([HeberGement:5])
	
	va_MPmot1:=""
	OBJECT SET ENABLED:C1123(b_Val; False:C215)
	
End if 
