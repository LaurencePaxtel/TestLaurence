C_OBJECT:C1216($position_o)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (User in group:C338(Current user:C182; "GestionStock")=True:C214)
			$position_o:=New object:C1471("ecartHautEcran"; Tool bar height:C1016+Menu bar height:C440+10; "ecartBasEcran"; 70)
			
			outilsCreateWindowsForm("Gestion"; ->$position_o; New object:C1471; ->[StockBis:122])
		Else 
			ALERT:C41("Fonction indisponible")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 