C_TEXT:C284($position_t)

If (User in group:C338(Current user:C182; "GestionStock")=True:C214)
	$position_t:="center"
	outilsCreateWindowsForm("Disponibilite"; ->$position_t; New object:C1471; ->[StockBis:122])
	
	Form_o.reinitialisation:=True:C214
	POST OUTSIDE CALL:C329(Current process:C322)
Else 
	ALERT:C41("Fonction indisponible")
End if 