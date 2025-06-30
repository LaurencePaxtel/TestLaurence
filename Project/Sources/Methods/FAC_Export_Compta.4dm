//%attributes = {}
// ======================================================================
// Methode projet : FAC_Export_Compta
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 22/01/20 Kevin HASSAL - Création
	// 18/12/20 remy@connect-io.fr - Reprise export sous format comptable
End if 

If (True:C214)  // Déclarations
	C_TEXT:C284($send; $cr; $sep; $compteComptable_t)
	C_LONGINT:C283($i; $nb_fiches; $progress_id)
	C_TIME:C306($ref_doc)
	
	C_OBJECT:C1216($table_o)
End if 

$ref_doc:=Create document:C266(""; "csv")

$cr:=Char:C90(Retour chariot:K15:38)
$sep:=";"

$send:="Compte comptable produit"+$sep+"Debit"+$sep+"Credit"+$sep+"Date facture"+$sep+"Numero"+$cr

$progress_id:=Progress New

Progress SET TITLE($progress_id; "Export des données..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; False:C215)

$nb_fiches:=Records in selection:C76([Factures:86])

READ ONLY:C145([Factures:86])
READ ONLY:C145([Factures_Lignes:87])

For ($i; 1; Size of array:C274(tb_fac_choix))
	Progress SET PROGRESS($progress_id; $i/$nb_fiches; "Import des enregistrements "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
	Progress SET MESSAGE($progress_id; " Export des factures en comptabilité "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
	
	If (tb_fac_choix{$i})
		QUERY:C277([Factures:86]; [Factures:86]ID:1=tb_fac_id{$i})
		MultiSoc_Filter(->[Factures:86])
		
		If (Records in selection:C76([Factures:86])=1)
			QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
			MultiSoc_Filter(->[Factures_Lignes:87])
			
			$table_o:=ds:C1482.HeberGement.query("HG_HB_ID is :1"; [Factures:86]FAC_Destinataire_ID:11)
			
			If (Num:C11($table_o.length)>0)
				$compteComptable_t:=String:C10($table_o.HG_HB_ID_1_HB_ReferenceID.first().HB_Compte_Comptable)
			End if 
			
			// On rempli les lignes qui correspondent à la colonne "Crédit"
			ORDER BY:C49([Factures_Lignes:87]; [Factures_Lignes:87]FACL_No_Ordre:7; >)
			
			While (Not:C34(End selection:C36([Factures_Lignes:87])))
				
				$send:=$send+[Factures_Lignes:87]FACL_Compte_Comptable:28+$sep\
					+""+$sep\
					+String:C10([Factures_Lignes:87]FACL_Montant_TTC:12)+$sep\
					+String:C10([Factures:86]FAC_Date_Piece:3)+$sep\
					+String:C10([Factures:86]FAC_No_Piece:2)+$cr
				
				NEXT RECORD:C51([Factures_Lignes:87])
			End while 
			
			// Puis on ajoute la ligne qui correspond à la colonne "Débit"
			$send:=$send+$compteComptable_t+$sep\
				+String:C10([Factures:86]FAC_Montant_TTC:8)+$sep\
				+""+$sep\
				+""+$sep\
				+""+$cr
			
		End if 
		
	End if 
	
	CLEAR VARIABLE:C89($compteComptable_t)
End for 

Progress QUIT($progress_id)

If (String:C10($ref_doc)#"00:00:00")
	SEND PACKET:C103($ref_doc; $send)
	CLOSE DOCUMENT:C267($ref_doc)
	
	$excel:=UTL_trouve_excel
	$excel:=$excel+" \""+document+"\""
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
	LAUNCH EXTERNAL PROCESS:C811($excel)
End if 