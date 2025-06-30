var $fileName_t; $content_t : Text
var $situation_o : Object
var $export_f : 4D:C1709.File

$fileName_t:=Select document:C905(System folder:C487(Bureau:K41:16)+"exportSituation.csv"; "csv"; "Nom de du fichier d'export :"; Saisie nom de fichier:K24:17)

If (OK=1)
	$export_f:=File:C1566(Document; fk chemin plateforme:K87:2)
	
	For each ($situation_o; Form:C1466.situations)
		$content_t:=$content_t+$situation_o.FAC_Destinataire_Nom+Char:C90(Tabulation:K15:37)+String:C10($situation_o.soldeDue; "### ###,##0.00 €")
		
		If (Form:C1466.situations.indexOf($situation_o)<Form:C1466.situations.length)
			$content_t:=$content_t+Char:C90(Retour à la ligne:K15:40)
		End if 
		
	End for each 
	
	$export_f.setText($content_t)
	Form:C1466.notification_cs.popUp("success"; "Export réalisé"; "L'export du tableau des situations a bien été réalisée.")
End if 