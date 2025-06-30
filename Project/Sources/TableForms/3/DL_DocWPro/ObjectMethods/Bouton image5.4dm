Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Records in selection:C76([DOCWPRO:121])=1) & ([DOCWPRO:121]nom:3#"") & ([DOCWPRO:121]nom:3#"NOUVEAU DOCUMENT")
			SAVE RECORD:C53([DOCWPRO:121])
			
			ALERT:C41("Sauvegarde du document "+[DOCWPRO:121]nom:3+" effectué")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 