Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Records in selection:C76([DOCWPRO:121])=1) & ([DOCWPRO:121]nom:3#"NOUVEAU DOCUMENT")
			
			If (Form:C1466.elementPosition#0)
				
				If (Form:C1466.tag[Form:C1466.elementPosition-1].lib="Document Officiel")
					ALERT:C41("Impossible de supprimer ce tag")
				Else 
					Form:C1466.tag.remove(Form:C1466.elementPosition-1)
					[DOCWPRO:121]tag:5:=JSON Stringify:C1217(Form:C1466.tag.extract("lib"))
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Merci d'ouvrir un document avant de pouvoir supprimer un tag")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 