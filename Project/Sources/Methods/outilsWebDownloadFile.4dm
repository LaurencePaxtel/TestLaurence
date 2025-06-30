//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 03/04/23, 14:49:58
// ----------------------------------------------------
// Méthode : outilsWebDownloadFile
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Text

var $content_t : Text
var $accountProduct_i : Integer
var $stop_b; $debit_b : Boolean
var $period_d; $periodPrevious_d : Date
var $facture_c : Collection
var $export_f : 4D:C1709.File

var $facture_e : cs:C1710.FacturesEntity
var $facture_es : cs:C1710.FacturesSelection

var $factureLigne_e : cs:C1710.Factures_LignesEntity
var $factureLigne_es : cs:C1710.Factures_LignesSelection

var $location_e : cs:C1710.LocationsEntity
var $centre_e : cs:C1710.LesCentresEntity
var $heberge_e : cs:C1710.HeBergeEntity
var $societe_e : cs:C1710.SOcieteEntity

var $charge_es; $chargeB_es : cs:C1710.ChargesSelection

ARRAY TEXT:C222($facture_at; 0)

$retour_o:=New object:C1471

Case of 
	: (w_visiteur.action="exportFacture")
		$export_f:=Folder:C1567(fk dossier racine web:K87:15).file("customContent/"+String:C10(w_visiteur.Ref_Structure)+"/exportFacture/exportFacture.csv")
		
		$facture_c:=New collection:C1472
		
		JSON PARSE ARRAY:C1219(w_visiteur.records; $facture_at)
		ARRAY TO COLLECTION:C1563($facture_c; $facture_at)
		
		$facture_c:=$facture_c.map("outilsCollectionValueToNum")
		$facture_es:=ds:C1482.Factures.query("ID in :1"; $facture_c)
		
		$content_t:="Version"+Char:C90(Tabulation:K15:37)+"EEme"+Char:C90(Tabulation:K15:37)+"SEme"+Char:C90(Tabulation:K15:37)+"ERecpt"+Char:C90(Tabulation:K15:37)+"SRecpt"+Char:C90(Tabulation:K15:37)+"CJal"+Char:C90(Tabulation:K15:37)+"CSaisie"+Char:C90(Tabulation:K15:37)+\
			"CptTreso"+Char:C90(Tabulation:K15:37)+"EDate"+Char:C90(Tabulation:K15:37)+"Npiece"+Char:C90(Tabulation:K15:37)+"NFolio"+Char:C90(Tabulation:K15:37)+"NCompte"+Char:C90(Tabulation:K15:37)+"Debit"+Char:C90(Tabulation:K15:37)+"Credit"+Char:C90(Tabulation:K15:37)+"Libelle"+Char:C90(Tabulation:K15:37)+\
			"NFact"+Char:C90(Tabulation:K15:37)+"RefBanque"+Char:C90(Tabulation:K15:37)+"DateE"+Char:C90(Tabulation:K15:37)+"CLettrage"+Char:C90(Retour à la ligne:K15:40)
		
		For each ($facture_e; $facture_es) Until ($stop_b=True:C214)
			$factureLigne_es:=$facture_e.AllFacturesLigne.orderBy("FACL_Montant_TTC desc")
			
			outilsOrdaSearchSimple(->[LesCentres:9]; ->[LesCentres:9]ID:60; $facture_e.FAC_Bien_ID; ->$centre_e; "first")
			outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]ID:65; $facture_e.FAC_Locataire_ID; ->$heberge_e; "first")
			outilsOrdaSearchSimple(->[Locations:84]; ->[Locations:84]ID:1; $facture_e.FAC_Location_ID; ->$location_e; "first")
			
			If ($centre_e#Null:C1517)
				$stop_b:=($centre_e.OneFactureExport=Null:C1517)
				
				If ($stop_b=True:C214) & ($retour_o.notificationError=Null:C1517)
					$retour_o.notificationError:="Impossible de faire l'export sur des factures car le centre « "+$centre_e.LC_Nom+" » n'est pas rattaché à un service"
				End if 
				
				If ($stop_b=False:C215)
					outilsOrdaSearchSimple(->[SOciete:18]; ->[SOciete:18]ID:94; $centre_e.OneFactureExport.OneStructure.STRC_Societe_ID; ->$societe_e; "first")
					$period_d:=Date:C102("01/"+Replace string:C233(String:C10($facture_e.FAC_Periode); "-"; "/"))
					
					If ($periodPrevious_d#!00-00-00!)  // On est déjà passé sur une facture
						$stop_b:=(Year of:C25($period_d)#Year of:C25($periodPrevious_d))
					End if 
					
					If ($stop_b=True:C214) & ($retour_o.notificationError=Null:C1517)
						$retour_o.notificationError:="Impossible de faire l'export sur des factures qui sont sur plusieurs années !"
					End if 
					
					If ($stop_b=False:C215)
						$periodPrevious_d:=$period_d
						
						// Ajout de la première ligne débit (Loyer+charge-APL)
						$content_t:=$content_t+"2.0"+Char:C90(Tabulation:K15:37)+"ET01"+Char:C90(Tabulation:K15:37)+"1000"+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+"VE"+Char:C90(Tabulation:K15:37)+"VEUS"+Char:C90(Tabulation:K15:37)+\
							""+Char:C90(Tabulation:K15:37)+String:C10($facture_e.FAC_Date_Piece)+Char:C90(Tabulation:K15:37)+Replace string:C233($facture_e.FAC_No_Piece; "FAC/"; "")+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
							String:C10($centre_e.OneFactureExport.sectionCodeThird)+Uppercase:C13($heberge_e.HB_Nom)+Char:C90(Tabulation:K15:37)+Choose:C955($facture_e.FAC_Montant_TTC>=0; String:C10($facture_e.FAC_Montant_TTC); "")+Char:C90(Tabulation:K15:37)+Choose:C955($facture_e.FAC_Montant_TTC<0; String:C10(Abs:C99($facture_e.FAC_Montant_TTC)); "")+Char:C90(Tabulation:K15:37)+\
							"Loyer de "+Lowercase:C14(outilsGetLibDate(2; $period_d))+" "+String:C10(Year of:C25($period_d))+" - "+$facture_e.FAC_Locataire_Nom+Char:C90(Tabulation:K15:37)+$facture_e.FAC_No_Piece+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
							String:C10($facture_e.FAC_Date_Echeance)+Char:C90(Tabulation:K15:37)+""+Char:C90(Retour à la ligne:K15:40)
						
						// Ajout des lignes de crédit ou débit (Loyer | charge | apl)
						$charge_es:=ds:C1482.Charges.query("CHA_Origine_Table_No = :1 AND CHA_Origine_ID = :2"; Table:C252(->[Locations:84]); $location_e.ID)
						
						For each ($factureLigne_e; $factureLigne_es)
							$debit_b:=($factureLigne_e.FACL_Type_Ligne="apl")
							
							Case of 
								: ($factureLigne_e.FACL_Type_Ligne="location") | ($factureLigne_e.FACL_Type_Ligne="apl")
									$accountProduct_i:=$societe_e.comptabilite.loyer
								: ($factureLigne_e.FACL_Type_Ligne="charge")
									$chargeB_es:=$charge_es.query("CHA_Libelle = :1"; $factureLigne_e.FACL_Titre)
									
									If ($chargeB_es.length=1)
										$accountProduct_i:=$chargeB_es.first().CHA_Account_Product
									End if 
									
							End case 
							
							$content_t:=$content_t+"2.0"+Char:C90(Tabulation:K15:37)+"ET01"+Char:C90(Tabulation:K15:37)+"1000"+Char:C90(Tabulation:K15:37)+"ET01"+Char:C90(Tabulation:K15:37)+String:C10($centre_e.OneFactureExport.sectionCode)+Char:C90(Tabulation:K15:37)+"VE"+Char:C90(Tabulation:K15:37)+\
								"VEUS"+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+String:C10($facture_e.FAC_Date_Piece)+Char:C90(Tabulation:K15:37)+Replace string:C233($facture_e.FAC_No_Piece; "FAC/"; "")+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
								String:C10($accountProduct_i)+Char:C90(Tabulation:K15:37)+Choose:C955($debit_b=True:C214; String:C10(Abs:C99($factureLigne_e.FACL_Montant_TTC)); "")+Char:C90(Tabulation:K15:37)+Choose:C955($debit_b=False:C215; String:C10($factureLigne_e.FACL_Montant_TTC); "")+Char:C90(Tabulation:K15:37)+\
								"Loyer de "+Lowercase:C14(outilsGetLibDate(2; $period_d))+" "+String:C10(Year of:C25($period_d))+" - "+$facture_e.FAC_Locataire_Nom+Char:C90(Tabulation:K15:37)+$facture_e.FAC_No_Piece+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
								String:C10($facture_e.FAC_Date_Echeance)+Char:C90(Tabulation:K15:37)+""+Char:C90(Retour à la ligne:K15:40)
							
							outilsCleanVariable(->$debit_b; ->$accountProduct_i)
						End for each 
						
					End if 
					
				End if 
				
			End if 
			
		End for each 
		
		If ($stop_b=False:C215)
			READ WRITE:C146([Factures:86])
			
			USE ENTITY SELECTION:C1513($facture_es)
			LOAD RECORD:C52([Factures:86])
			
			APPLY TO SELECTION:C70([Factures:86]; [Factures:86]FAC_Export:64:=True:C214)
			$export_f.setText($content_t)
			
			$retour_o.url:="/customContent/"+String:C10(w_visiteur.Ref_Structure)+"/exportFacture/exportFacture.csv"
			$retour_o.fileName:="IEC["+String:C10(Year of:C25($period_d))+"]export.csv"
		End if 
		
End case 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))