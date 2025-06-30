Case of 
	: (Form event code:C388=Sur clic entête:K2:40)
		Form:C1466.clicEntete.dateFacture:=Form:C1466.clicEntete.dateFacture+1
		
		If (Mod:C98(Form:C1466.clicEntete.dateFacture; 2)=0)
			ORDER BY:C49([Factures:86]; [Factures:86]FAC_Destinataire_Nom:13; >; [Factures:86]FAC_Annee:34; >; [Factures:86]FAC_Mois:33; >)
		Else 
			ORDER BY:C49([Factures:86]; [Factures:86]FAC_Destinataire_Nom:13; >; [Factures:86]FAC_Annee:34; <; [Factures:86]FAC_Mois:33; <)
		End if 
		
End case 