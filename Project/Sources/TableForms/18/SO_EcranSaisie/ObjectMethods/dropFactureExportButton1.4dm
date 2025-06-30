Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Form:C1466.FactureExport_e#Null:C1517)
			CONFIRM:C162("Souhaitez-vous vraiment supprimer l'enregistrement ?"; "Oui"; "Non")
			
			If (OK=1)
				Form:C1466.FactureExport_e.drop()
				
				Form:C1466.Structure_e.reload()
				Form:C1466.FactureExport_es:=Form:C1466.Structure_e.AllFactureExport
			End if 
			
		Else 
			ALERT:C41("Veuillez sélectionner un enregistrement")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 