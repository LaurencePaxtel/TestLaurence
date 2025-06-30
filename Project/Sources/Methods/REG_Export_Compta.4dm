//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 22/01/20, 08:40:22
// ----------------------------------------------------
// Method: FAG_Export_Compta
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($send)
C_LONGINT:C283($i; $nb_fiches)

$cr:=Char:C90(Retour chariot:K15:38)
$sep:=";"
$ref_doc:=Create document:C266(""; "csv")
$send:="Compte comptable usager"+$sep+"Compte comptable produit"+$sep+"TOTAL TTC"+$sep+"Type"+$sep+"Libellé"+$cr
$i:=0

$progress_id:=Progress New
Progress SET TITLE($progress_id; "Export des données..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; False:C215)

$nb_fiches:=Records in selection:C76([Factures:86])

FIRST RECORD:C50([Reglements:93])

While (Not:C34(End selection:C36([Reglements:93])))
	
	$i:=$i+1
	
	Progress SET PROGRESS($progress_id; $i/$nb_fiches; "Import des enregistrements "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
	Progress SET MESSAGE($progress_id; " Export des factures en comptabilité "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
	
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Reglements:93]REG_Origine_ID:18)
	MultiSoc_Filter(->[HeBerge:4])
	
	$send:=$send+[HeBerge:4]HB_Compte_Comptable:73+$sep+[LesCentres:9]LC_Compte_Comptable:72+$sep+String:C10([Reglements:93]REG_Montant:5)+$sep+[Reglements:93]REG_Type:15+$sep+[Reglements:93]REG_Libelle:28+$cr
	
	NEXT RECORD:C51([Reglements:93])
End while 


Progress QUIT($progress_id)

If (String:C10($ref_doc)#"00:00:00")
	
	SEND PACKET:C103($ref_doc; $send)
	
	CLOSE DOCUMENT:C267($ref_doc)
	
	
	$excel:=UTL_trouve_excel
	$excel:=$excel+" \""+document+"\""
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
	LAUNCH EXTERNAL PROCESS:C811($excel)
	
End if 


