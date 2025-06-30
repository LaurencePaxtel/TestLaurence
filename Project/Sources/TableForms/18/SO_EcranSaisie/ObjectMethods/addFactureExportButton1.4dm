var $factureExport_e : cs:C1710.FactureExportEntity

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CONFIRM:C162("Souhaitez-vous vraiment créer un nouvel enregistrement ?"; "Oui"; "Non")
		
		If (OK=1)
			$factureExport_e:=ds:C1482.FactureExport.new()
			
			$factureExport_e.structureID:=Form:C1466.Structure_e.UID
			$factureExport_e.save()
			
			Form:C1466.Structure_e.reload()
			Form:C1466.FactureExport_es:=Form:C1466.Structure_e.AllFactureExport
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 