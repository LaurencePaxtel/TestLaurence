Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_BOOLEAN:C305(chk_envoie_courrier)
		chk_envoie_courrier:=[HeBerge:4]HB_FAC_Envoie_Courrier:78
		
	: (Form event code:C388=Sur clic:K2:4)
		[HeBerge:4]HB_FAC_Envoie_Courrier:78:=chk_envoie_courrier
		
		If (chk_envoie_courrier)
			chk_envoie_mail:=False:C215
			
			READ WRITE:C146([Factures:86])
			QUERY:C277([Factures:86]; [Factures:86]FAC_Destinataire_ID:11=[HeBerge:4]HB_ReferenceID:1)
			MultiSoc_Filter(->[Factures:86])
			APPLY TO SELECTION:C70([Factures:86]; [Factures:86]FAC_Mode_Envoie:45:="Courrier")
			UNLOAD RECORD:C212([Factures:86])
			READ ONLY:C145([Factures:86])
			
		End if 
		
		
		
End case 