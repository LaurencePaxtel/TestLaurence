var $fileName_t : Text
var $content_o : Object
var $factureID_c : Collection

var $export_f : 4D:C1709.File

$factureID_c:=New collection:C1472
ARRAY TO COLLECTION:C1563($factureID_c; tb_fac_id)

$facture_es:=ds:C1482.Factures.query("ID in :1"; $factureID_c).orderBy("FAC_Annee asc, FAC_Mois asc")

If ($facture_es.length>0)
	$fileName_t:=Select document:C905(System folder:C487(Bureau:K41:16)+"IEC["+String:C10($facture_es[0].FAC_Annee)+"]export.csv"; "csv"; "Nom de du fichier d'export pour les factures :"; Saisie nom de fichier:K24:17)
	
	If ($fileName_t#"")
		$export_f:=File:C1566(Document; fk chemin plateforme:K87:2)
		$content_o:=$facture_es.exportCompta(1)
		
		If (String:C10($content_o.notificationError)#"")
			ALERT:C41($content_o.notificationError)
		Else 
			$export_f.setText($content_o.export)
			ALERT:C41("L'export a été réalisé avec succès")
		End if 
		
	Else 
		ALERT:C41("Export annulé, nom du fichier vide")
	End if 
	
Else 
	ALERT:C41("Aucune facture n'est présent dans la sélection, export impossible")
End if 