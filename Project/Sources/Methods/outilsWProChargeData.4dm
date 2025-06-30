//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 12/08/22, 16:26:16
// ----------------------------------------------------
// Méthode : outilsWProChargeData
// Description
// Charge les données dans les documents 4WP quand 
// le document est appelé depuis le web
//
// Paramètres
// ----------------------------------------------------
var $1 : Text
var $2 : Pointer
var $3 : Boolean  // Indique si on est dans un contexte 4D [Optionnel]

var $chargeDataCase_t : Text
var $mois_el; $annee_el; $index_el : Integer
var $contexte4D_b : Boolean
var $tableau_o; $row_o; $extra_o; $colonne_o; $cellule_o; $dette_o; $ligne_o; $charge_o; $ressource_o; $element_o : Object
var $element_c; $extra_c; $liste_c : Collection

var wpVar_o : Object

var $heberge_e : cs:C1710.HeBergeEntity

var $proprietaire_e : cs:C1710.ProprietairesEntity

var $adresse_e : cs:C1710.AdressesEntity

var $facture_e : cs:C1710.FacturesEntity
var $facture_es : cs:C1710.FacturesSelection

var $factureLigne_e : cs:C1710.Factures_LignesEntity
var $factureLigne_es : cs:C1710.Factures_LignesSelection

var $reglement_es : cs:C1710.ReglementsSelection

var $equipementBien_e : cs:C1710.EquipementBienEntity
var $equipementBien_es : cs:C1710.EquipementBienSelection

var $giIntervenant_e : cs:C1710.GI_IntervenantsEntity
var $giIntervenant_es : cs:C1710.GI_IntervenantsSelection

var $docwpro_e : cs:C1710.DOCWPROEntity
var $docwpro_es : cs:C1710.DOCWPROSelection

wpVar_o:=New object:C1471

// Modifié par : Scanu Rémy (18/04/2023)
If (Count parameters:C259=3)
	$contexte4D_b:=$3
End if 

outilsOrdaSearchSimple(->[DOCWPRO:121]; ->[DOCWPRO:121]nom:3; $1; ->$docwpro_es)
outilsOrdaSearchByRefStctre(->$docwpro_es; String:C10(w_visiteur.Ref_Structure); "structureRef")

$chargeDataCase_t:=$1

If ($docwpro_es.length>0)
	$docwpro_e:=$docwpro_es.first()
	
	If ($docwpro_e.chargeData#"")
		$chargeDataCase_t:=$docwpro_e.chargeData
	End if 
	
End if 

Case of 
	: ($chargeDataCase_t="Etat des lieux@")
		// Recherche de la location
		QUERY:C277([Locations:84]; [Locations:84]ID:1=Num:C11(w_visiteur.locationID))
		
		// Recherche de l'hébergé
		QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Locations:84]LOC_HB_ID:3)
		
		// Recherche du bien
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Locations:84]LOC_Bien_ID:5)
		
		// Recherche du propriétaire
		QUERY:C277([Proprietaires:83]; [Proprietaires:83]ID:1=[LesCentres:9]LC_GL_Proprietaire_ID:66)
		
		// Recherche des inventaires
		QUERY:C277([Inventaire_Pieces:96]; [Inventaire_Pieces:96]INV_ID_Bien:18=[LesCentres:9]ID:60)
		
		// Recherche des équipements
		$element_c:=New collection:C1472
		$element_c:=WP Get elements:C1550($2->; wk type table:K81:222)
		
		$tableau_o:=WP Get element by ID:C1549($2->; "t8")
		$equipementBien_es:=ds:C1482.EquipementBien.query("bienID = :1"; [LesCentres:9]ID:60)
		
		For each ($equipementBien_e; $equipementBien_es)
			$row_o:=WP Table append row:C1474($tableau_o; $equipementBien_e.OneEquipement.EQU_Nom; $equipementBien_e.quantite; ""; ""; ""; $equipementBien_e.quantite; ""; ""; "")
		End for each 
		
	: ($chargeDataCase_t="Fiche d'intervention")
		SOC_Get_Config
		
		// Recherche de l'intervention
		QUERY:C277([Intervention:108]; [Intervention:108]ID:1=Num:C11(w_visiteur.interventionID))
		
		// Recherche du bien
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=Num:C11(w_visiteur.lescentresID))
		
		// Recherche du référent
		QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=4; *)
		QUERY:C277([INtervenants:10];  & ; [INtervenants:10]IN_Login:3=[Intervention:108]INT_Referent:24)
		MultiSoc_Filter(->[INtervenants:10])
		
		// Recherche des intervenants
		$element_c:=New collection:C1472
		$element_c:=WP Get elements:C1550($2->; wk type table:K81:222)
		
		$tableau_o:=WP Get element by ID:C1549($2->; "t8")
		
		RELATE MANY:C262([Intervention:108]ID:1)
		RELATE ONE SELECTION:C349([GI_LK_Intervenants:112]; [GI_Intervenants:110])
		
		$giIntervenant_es:=Create entity selection:C1512([GI_Intervenants:110])
		
		For each ($giIntervenant_e; $giIntervenant_es)
			$row_o:=WP Table append row:C1474($tableau_o; $giIntervenant_e.GII_Nom; $giIntervenant_e.GII_Prenom; $giIntervenant_e.GII_Societe)
			WP SET ATTRIBUTES:C1342($row_o; wk font bold:K81:68; False:C215)
		End for each 
		
		// Recherche de l'hébergé
		RELATE ONE SELECTION:C349([Intervention:108]; [HeBerge:4])
	: ($chargeDataCase_t="Facture individuelle")
		SOC_Get_Config
		
		// Recherche de la facture
		QUERY:C277([Factures:86]; [Factures:86]ID:1=Num:C11(w_visiteur.factureID))
		
		// Recherche de la societe
		QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=[Factures:86]Ref_Structure:19)
		QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
		
		// Recherche de la location
		QUERY:C277([Locations:84]; [Locations:84]ID:1=[Factures:86]FAC_Location_ID:39)
		
		// Recherche du centre
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Locations:84]LOC_Bien_ID:5)
		
		// Recherche du destinataire
		wpVar_o.prenom:=""
		wpVar_o.nom:=""
		
		wpVar_o.adresse:=""
		wpVar_o.cpVille:=""
		
		Case of 
			: ([Factures:86]FAC_Destinataire_Table_Origine:12=83)  // Propriétaire
				$proprietaire_e:=ds:C1482.Proprietaires.get([Factures:86]FAC_Destinataire_ID:11)
				
				If ($proprietaire_e#Null:C1517)
					wpVar_o.prenom:=$proprietaire_e.PRO_Prenom
					wpVar_o.nom:=$proprietaire_e.PRO_Nom
					
					$adresse_e:=ds:C1482.Adresses.searchAndCreateRecordIfDontExist($proprietaire_e.ID; Table:C252(->[Proprietaires:83]); w_visiteur.Ref_Structure)
				End if 
				
			: ([Factures:86]FAC_Destinataire_Table_Origine:12=4)  // Locataire (Hébergé)
				$heberge_e:=ds:C1482.HeBerge.get([Factures:86]FAC_Destinataire_ID:11)
				
				If ($heberge_e#Null:C1517)
					wpVar_o.prenom:=$heberge_e.HB_Prénom
					wpVar_o.nom:=$heberge_e.HB_Nom
					
					$adresse_e:=ds:C1482.Adresses.searchAndCreateRecordIfDontExist($heberge_e.ID; Table:C252(->[HeBerge:4]); w_visiteur.Ref_Structure)
				End if 
				
		End case 
		
		If ($adresse_e#Null:C1517)
			
			If ($adresse_e.AD_Adresse1#"")
				wpVar_o.adresse:=$adresse_e.AD_Adresse1
			End if 
			
			If ($adresse_e.AD_Adresse2#"")
				
				If (wpVar_o.adresse#"")
					wpVar_o.adresse:=wpVar_o.adresse+Char:C90(Retour à la ligne:K15:40)
				End if 
				
				wpVar_o.adresse:=wpVar_o.adresse+$adresse_e.AD_Adresse2
			End if 
			
			If ($adresse_e.AD_Adresse3#"")
				
				If (wpVar_o.adresse#"")
					wpVar_o.adresse:=wpVar_o.adresse+Char:C90(Retour à la ligne:K15:40)
				End if 
				
				wpVar_o.adresse:=wpVar_o.adresse+$adresse_e.AD_Adresse3
			End if 
			
			If ($adresse_e.AD_Code_postal#"")
				wpVar_o.cpVille:=$adresse_e.AD_Code_postal
			End if 
			
			If ($adresse_e.AD_Ville#"")
				
				If (wpVar_o.cpVille#"")
					wpVar_o.cpVille:=wpVar_o.cpVille+" "
				End if 
				
				wpVar_o.cpVille:=wpVar_o.cpVille+$adresse_e.AD_Ville
			End if 
			
		End if 
		
		If (wpVar_o.adresse="")
			wpVar_o.adresse:="Adresse inconnue"
		End if 
		
		// Recherche des charges
		RELATE ONE SELECTION:C349([Factures:86]; [Factures_Lignes:87])
		$factureLigne_es:=Create entity selection:C1512([Factures_Lignes:87])
		
		$element_c:=New collection:C1472
		$element_c:=WP Get elements:C1550($2->; wk type table:K81:222)
		
		$tableau_o:=WP Get element by ID:C1549($2->; "t4")
		
		For each ($factureLigne_e; $factureLigne_es)
			$row_o:=WP Table append row:C1474($tableau_o; $factureLigne_e.FACL_Titre+Choose:C955($factureLigne_e.FACL_Libelle#""; " ("+$factureLigne_e.FACL_Libelle+")"; ""); String:C10($factureLigne_e.FACL_Montant_TTC; "### ###,##0.00 €"))
			$cellule_o:=WP Table get cells:C1477($tableau_o; 2; $tableau_o.rowCount)
			
			WP SET ATTRIBUTES:C1342($cellule_o; wk text align:K81:49; wk right:K81:96)
			
			WP SET ATTRIBUTES:C1342($cellule_o; wk font family:K81:65; "Arial")
			WP SET ATTRIBUTES:C1342($cellule_o; wk font size:K81:66; 11)
			
			$cellule_o:=WP Table get cells:C1477($tableau_o; 1; $tableau_o.rowCount)
			
			WP SET ATTRIBUTES:C1342($cellule_o; wk font family:K81:65; "Arial")
			WP SET ATTRIBUTES:C1342($cellule_o; wk font size:K81:66; 11)
		End for each 
		
		//Mark: Quittance & Avis
	: ($chargeDataCase_t="Quittance@") | ($chargeDataCase_t="Avis@")
		SOC_Get_Config
		
		// Recherche de la facture
		QUERY:C277([Factures:86]; [Factures:86]ID:1=Num:C11(w_visiteur.factureID))
		wpVar_o.facture:=ds:C1482.Factures.get([Factures:86]ID:1)
		
		// Recherche de la societe
		QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=[Factures:86]Ref_Structure:19)
		QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
		
		// Recherche de la location
		QUERY:C277([Locations:84]; [Locations:84]ID:1=[Factures:86]FAC_Location_ID:39)
		
		// Recherche du centre
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Locations:84]LOC_Bien_ID:5)
		
		// Recherche du destinataire
		wpVar_o.prenom:=""
		wpVar_o.nom:=""
		
		wpVar_o.adresse:=""
		wpVar_o.cpVille:=""
		
		Case of 
			: ([Factures:86]FAC_Destinataire_Table_Origine:12=83)  // Propriétaire
				$proprietaire_e:=ds:C1482.Proprietaires.get([Factures:86]FAC_Destinataire_ID:11)
				
				If ($proprietaire_e#Null:C1517)
					wpVar_o.prenom:=$proprietaire_e.PRO_Prenom
					wpVar_o.nom:=$proprietaire_e.PRO_Nom
					
					$adresse_e:=ds:C1482.Adresses.searchAndCreateRecordIfDontExist($proprietaire_e.ID; Table:C252(->[Proprietaires:83]); w_visiteur.Ref_Structure)
				End if 
				
			: ([Factures:86]FAC_Destinataire_Table_Origine:12=4)  // Locataire (Hébergé)
				$heberge_e:=ds:C1482.HeBerge.get([Factures:86]FAC_Destinataire_ID:11)
				
				If ($heberge_e#Null:C1517)
					wpVar_o.prenom:=$heberge_e.HB_Prénom
					wpVar_o.nom:=$heberge_e.HB_Nom
					
					$adresse_e:=ds:C1482.Adresses.searchAndCreateRecordIfDontExist($heberge_e.ID; Table:C252(->[HeBerge:4]); w_visiteur.Ref_Structure)
				End if 
				
		End case 
		
		If ($adresse_e#Null:C1517)
			
			If ($adresse_e.AD_Adresse1#"")
				wpVar_o.adresse:=$adresse_e.AD_Adresse1
			End if 
			
			If ($adresse_e.AD_Adresse2#"")
				
				If (wpVar_o.adresse#"")
					wpVar_o.adresse:=wpVar_o.adresse+Char:C90(Retour à la ligne:K15:40)
				End if 
				
				wpVar_o.adresse:=wpVar_o.adresse+$adresse_e.AD_Adresse2
			End if 
			
			If ($adresse_e.AD_Adresse3#"")
				
				If (wpVar_o.adresse#"")
					wpVar_o.adresse:=wpVar_o.adresse+Char:C90(Retour à la ligne:K15:40)
				End if 
				
				wpVar_o.adresse:=wpVar_o.adresse+$adresse_e.AD_Adresse3
			End if 
			
			If ($adresse_e.AD_Code_postal#"")
				wpVar_o.cpVille:=$adresse_e.AD_Code_postal
			End if 
			
			If ($adresse_e.AD_Ville#"")
				
				If (wpVar_o.cpVille#"")
					wpVar_o.cpVille:=wpVar_o.cpVille+" "
				End if 
				
				wpVar_o.cpVille:=wpVar_o.cpVille+$adresse_e.AD_Ville
			End if 
			
		End if 
		
		If (wpVar_o.adresse="")
			wpVar_o.adresse:="Adresse inconnue"
		End if 
		
		// Recherche de(s) réglement(s) de la facture du mois précédent
		If ([Factures:86]FAC_Mois:33=1)
			$facture_es:=ds:C1482.Factures.query("FAC_Mois = :1 AND FAC_Annee = :2"; 12; [Factures:86]FAC_Annee:34-1)
		Else 
			$facture_es:=ds:C1482.Factures.query("FAC_Mois = :1 AND FAC_Annee = :2"; [Factures:86]FAC_Mois:33-1; [Factures:86]FAC_Annee:34)
		End if 
		
		$facture_es:=$facture_es.query("FAC_Bien_ID = :1 AND FAC_Locataire_ID = :2"; [Locations:84]LOC_Bien_ID:5; [Locations:84]LOC_HB_ID:3)
		
		If ($facture_es.length>0)
			wpVar_o.paymentPreviousInvoice:=0
			wpVar_o.netAPayerPreviousInvoice:=0
			
			For each ($facture_e; $facture_es)
				wpVar_o.netAPayerPreviousInvoice+=$facture_e.FAC_Net_A_Payer_cal
				
				$reglement_es:=ds:C1482.Reglements.query("REG_Origine_IDS = :1"; "@"+String:C10($facture_e.ID)+"@")
				wpVar_o.paymentPreviousInvoice+=$reglement_es.sum("REG_Montant")
			End for each 
			
		End if 
		// Recherche du montant des APL pour le mois facturé
		$dateApl:=Date:C102("01/"+String:C10([Factures:86]FAC_Mois:33)+"/"+String:C10([Factures:86]FAC_Annee:34))-1
		$aplMoisPrecedent_e:=ds:C1482.LocationsAPL.query("locationID = :1 AND month = :2 AND year = :3"; [Locations:84]ID:1; Month of:C24($dateApl); Year of:C25($dateApl)).first()
		
		$aplMoisEnCours_e:=ds:C1482.LocationsAPL.query("locationID = :1 AND month = :2 AND year = :3"; [Locations:84]ID:1; [Factures:86]FAC_Mois:33; [Factures:86]FAC_Annee:34).first()
		
		// Recherche des charges
		RELATE ONE SELECTION:C349([Factures:86]; [Factures_Lignes:87])
		$factureLigne_es:=Create entity selection:C1512([Factures_Lignes:87])
		
		wpVar_o.charge:=New object:C1471
		
		If ($chargeDataCase_t="Quittance V2") | ($chargeDataCase_t="Avis V2")
			$element_c:=New collection:C1472
			$element_c:=WP Get elements:C1550($2->; wk type table:K81:222)
			
			$tableau_o:=WP Get element by ID:C1549($2->; "t4")
			wpVar_o.charge.amount:=0
		End if 
		
		For each ($factureLigne_e; $factureLigne_es.orderBy("FACL_Libelle"))
			
			If ($chargeDataCase_t="Quittance V2") | ($chargeDataCase_t="Avis V2")
				
				Case of 
					: ($factureLigne_e.FACL_Libelle="APL")
					: ($factureLigne_e.FACL_Libelle="Loyer")
						wpVar_o.charge.loyer:=$factureLigne_e.FACL_Montant_TTC
					Else 
						wpVar_o.charge.amount:=wpVar_o.charge.amount+$factureLigne_e.FACL_Montant_TTC
						$row_o:=WP Table append row:C1474($tableau_o; $factureLigne_e.FACL_Libelle; String:C10($factureLigne_e.FACL_Montant_TTC; "### ###,##0.00 €"))
						
						$cellule_o:=WP Table get cells:C1477($tableau_o; 2; $tableau_o.rowCount)
						
						WP SET ATTRIBUTES:C1342($cellule_o; wk text align:K81:49; wk right:K81:96)
						
						WP SET ATTRIBUTES:C1342($cellule_o; wk font family:K81:65; "Arial")
						WP SET ATTRIBUTES:C1342($cellule_o; wk font size:K81:66; 10)
						
						$cellule_o:=WP Table get cells:C1477($tableau_o; 1; $tableau_o.rowCount)
						
						WP SET ATTRIBUTES:C1342($cellule_o; wk font family:K81:65; "Arial")
						WP SET ATTRIBUTES:C1342($cellule_o; wk font size:K81:66; 10)
				End case 
				
			Else 
				
				Case of 
					: ($factureLigne_e.FACL_Libelle="Loyer")
						wpVar_o.charge.loyer:=$factureLigne_e.FACL_Montant_TTC
					: ($factureLigne_e.FACL_Libelle="Régularisation des charges")
						wpVar_o.charge.chargeRegularisation:=$factureLigne_e.FACL_Montant_TTC
					: ($factureLigne_e.FACL_Libelle="Assurance logement")
						wpVar_o.charge.assuranceLogement:=$factureLigne_e.FACL_Montant_TTC
					: ($factureLigne_e.FACL_Libelle="Régularisation assurance logement")
						wpVar_o.charge.assuranceLogementRegularisation:=$factureLigne_e.FACL_Montant_TTC
					: ($factureLigne_e.FACL_Libelle="Autres")
						wpVar_o.charge.autres:=$factureLigne_e.FACL_Montant_TTC
				End case 
				
			End if 
			
		End for each 
		
		If ($chargeDataCase_t="Quittance V2") | ($chargeDataCase_t="Avis V2")
			wpVar_o.totalEcheances:=Num:C11(wpVar_o.charge.loyer)+Num:C11(wpVar_o.charge.amount)+$aplMoisPrecedent_e.pending-$aplMoisPrecedent_e.receive+$aplMoisEnCours_e.pending-\
				[Factures:86]FAC_Solde_Regle:26
		Else 
			wpVar_o.totalEcheances:=[Factures:86]FAC_Montant_TTC:8+[Factures:86]FAC_Total_Charges:53+Num:C11(wpVar_o.charge.chargeRegularisation)+\
				$aplMoisPrecedent_e.pending-$aplMoisPrecedent_e.receive+$aplMoisEnCours_e.pending+Num:C11(wpVar_o.charge.assuranceLogement)+\
				Num:C11(wpVar_o.charge.assuranceLogementRegularisation)+Num:C11(wpVar_o.charge.autres)
		End if 
		
		wpVar_o.charge.aplAttendu:=$aplMoisEnCours_e.pending
		
		//Mark: Appel participation
	: ($chargeDataCase_t="Appel participation")
		
		// Recherche de la participation
		If ($contexte4D_b=True:C214)
			QUERY:C277([Participations:116]; [Participations:116]ID:1=[Factures:86]FAC_Participation_ID:62)
			QUERY:C277([ParticipationWeb:140]; [ParticipationWeb:140]ID:1=[Participations:116]PAR_participationWebID:36)
			QUERY:C277([ParticipationsWebBudget:138]; [ParticipationsWebBudget:138]hebergeID:2=[Participations:116]PAR_HB_ID:2; *)
			QUERY:C277([ParticipationsWebBudget:138];  & ; [ParticipationsWebBudget:138]annee:3=[Participations:116]PAR_Annee:3; *)
			QUERY:C277([ParticipationsWebBudget:138];  & ; [ParticipationsWebBudget:138]mois:4=[Participations:116]PAR_Mois:4)
		End if 
		
		// Recherche du centre
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Factures:86]FAC_Bien_ID:28)
		
		// Recherche de l'hébergé
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Factures:86]FAC_Destinataire_ID:11)
		
		// Recherche de l'hébergement
		RELATE ONE SELECTION:C349([HeBerge:4]; [HeberGement:5])
		
		$mois_el:=Month of:C24(Date:C102("01/"+[Factures:86]FAC_Mois_Annee:48))
		$annee_el:=Year of:C25(Date:C102("01/"+[Factures:86]FAC_Mois_Annee:48))
		
		QUERY SELECTION BY FORMULA:C207([HeberGement:5]; Month of:C24([HeberGement:5]HG_Date:4)=$mois_el)
		QUERY SELECTION BY FORMULA:C207([HeberGement:5]; Year of:C25([HeberGement:5]HG_Date:4)=$annee_el)
		
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
		
		// Recherche de(s) règlement(s) de la facture du mois précédent
		If ([Factures:86]FAC_Mois:33=1)
			$facture_es:=ds:C1482.Factures.query("FAC_Mois = :1 AND FAC_Annee = :2"; 12; [Factures:86]FAC_Annee:34-1)
		Else 
			$facture_es:=ds:C1482.Factures.query("FAC_Mois = :1 AND FAC_Annee = :2"; [Factures:86]FAC_Mois:33-1; [Factures:86]FAC_Annee:34)
		End if 
		
		$facture_es:=$facture_es.query("FAC_Origine_ID = :1"; [Participations:116]PAR_HB_ID:2)
		
		wpVar_o.soldeMoisPrecedent:=0
		wpVar_o.sommeRegle:=0
		wpVar_o.soldeAnterieurDu:=0
		
		If ($facture_es.length>0)
			$reglement_es:=ds:C1482.Reglements.query("REG_Origine_IDS = :1"; "@"+String:C10($facture_es[0].ID)+"@").orderBy("REG_Date_Piece desc, ID desc")
			
			If ($reglement_es.length>0)
				wpVar_o.sommeRegle:=-$reglement_es[0].REG_Montant
			End if 
			
		End if 
		
		// Recherche des charges "Extra"
		$element_c:=New collection:C1472
		$element_c:=WP Get elements:C1550($2->; wk type table:K81:222)
		
		$tableau_o:=WP Get element by ID:C1549($2->; "t7")
		$extra_c:=New collection:C1472
		
		If ([Participations:116]PAR_Extra:35#Null:C1517)
			$extra_c:=[Participations:116]PAR_Extra:35.detail.query("montant > :1"; 0)
		End if 
		
		For each ($extra_o; $extra_c)
			$row_o:=WP Table append row:C1474($tableau_o; $extra_o.libelle; String:C10($extra_o.montant; "### ###,##0.00 €"))
		End for each 
		
		If ($extra_c.length>0)  // Ajout d'un sous-total des charges
			$row_o:=WP Table append row:C1474($tableau_o; "Sous-total"; String:C10($extra_c.sum("montant"); "### ###,##0.00 €"))
			
			$cellule_o:=WP Table get cells:C1477($tableau_o; 2; $tableau_o.rowCount)
			WP SET ATTRIBUTES:C1342($cellule_o; wk font bold:K81:68; True:C214)
			
			$colonne_o:=WP Table get columns:C1476($tableau_o; 2)
			WP SET ATTRIBUTES:C1342($colonne_o; wk text align:K81:49; wk right:K81:96)
		End if 
		
		// Quoi qu'il arrive je supprime la première ligne vide
		WP TABLE DELETE ROWS:C1693($tableau_o; 1)
		wpVar_o.totalEcheances:=$extra_c.sum("montant")+[Participations:116]PAR_Montant_Participation:18
		
		wpVar_o.soldeAnterieurDu:=ds:C1482.Factures.get([Factures:86]ID:1).FAC_Solde_Du_cal-wpVar_o.totalEcheances
		wpVar_o.soldeMoisPrecedent:=wpVar_o.soldeAnterieurDu-wpVar_o.sommeRegle
		
		wpVar_o.facturesLignes_es:=Create entity selection:C1512([Factures_Lignes:87])
		
		
		//Mark: Demande FSL
	: ($chargeDataCase_t="Demande FSL")
		SOC_Get_Config
		
		// Recherche de l'hébergé
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=Num:C11(w_visiteur.hebergeID))
		
		// Recherche de l'hébergement
		RELATE ONE SELECTION:C349([HeBerge:4]; [HeberGement:5])
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
		
		// Recherche du référent
		QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=4; *)
		QUERY:C277([INtervenants:10];  & ; [INtervenants:10]IN_Login:3=[HeberGement:5]HG_Permanencier:9)
		MultiSoc_Filter(->[INtervenants:10])
		
		wpVar_o.loyer:=Num:C11([HeBerge:4]situationBudgetaire:85.budget.loyer)
		wpVar_o.charge:=Num:C11([HeBerge:4]situationBudgetaire:85.budget.charge.sum("value"))
		wpVar_o.total:=wpVar_o.loyer+wpVar_o.charge
		
		wpVar_o.apl:=Num:C11([HeBerge:4]situationBudgetaire:85.budget.apl)
		wpVar_o.loyerChargeFamille:=wpVar_o.total-wpVar_o.apl
		
		// Recherche des "Ressources" et "Charges"
		$element_c:=New collection:C1472
		$element_c:=WP Get elements:C1550($2->; wk type table:K81:222)
		
		$tableau_o:=WP Get element by ID:C1549($2->; "t12")
		
		$row_o:=WP Table append row:C1474($tableau_o; "Salaire : "+String:C10([HeBerge:4]situationBudgetaire:85.budget.salaire; "### ###,##0.00 €"); "Loyer : "+String:C10([HeBerge:4]situationBudgetaire:85.budget.loyer; "### ###,##0.00 €"); "")
		
		For each ($charge_o; [HeBerge:4]situationBudgetaire:85.budget.charge)
			$index_el:=[HeBerge:4]situationBudgetaire:85.budget.charge.indexOf($charge_o)
			$row_o:=WP Table append row:C1474($tableau_o; Choose:C955($index_el=0; "APL : "+String:C10([HeBerge:4]situationBudgetaire:85.budget.apl; "### ###,##0.00 €"); ""); $charge_o.lib+" : "+String:C10($charge_o.value; "### ###,##0.00 €"); "")
			
			If ($charge_o.lib="Nouvelle charge") & ($charge_o.value=0)
				$cellule_o:=WP Table get cells:C1477($tableau_o; 2; $index_el+3)
				WP SET TEXT:C1574($cellule_o; ""; wk replace:K81:177)
			End if 
			
		End for each 
		
		For each ($ressource_o; [HeBerge:4]situationBudgetaire:85.budget.ressource)
			$index_el:=[HeBerge:4]situationBudgetaire:85.budget.ressource.indexOf($ressource_o)
			
			If ($ressource_o.lib#"Nouvelle ressource") & ($ressource_o.value#0)
				$cellule_o:=WP Table get cells:C1477($tableau_o; 1; $index_el+4)
				WP SET TEXT:C1574($cellule_o; $ressource_o.lib+" : "+String:C10($ressource_o.value; "### ###,##0.00 €"); wk replace:K81:177)
			End if 
			
		End for each 
		
		wpVar_o.totalRessource:=[HeBerge:4]situationBudgetaire:85.budget.ressource.sum("value")+[HeBerge:4]situationBudgetaire:85.budget.apl+[HeBerge:4]situationBudgetaire:85.budget.salaire
		wpVar_o.totalCharge:=[HeBerge:4]situationBudgetaire:85.budget.charge.sum("value")+[HeBerge:4]situationBudgetaire:85.budget.loyer
		
		wpVar_o.moyenneEconomiqueJournaliere:=String:C10(Round:C94(((wpVar_o.totalRessource-wpVar_o.totalCharge)/[HeBerge:4]situationBudgetaire:85.nbPersonneMenage)/30; 0); "### ###,##0.00 €")
		
		$row_o:=WP Table append row:C1474($tableau_o; "Total : "+String:C10(wpVar_o.totalRessource; "### ###,##0.00 €"); \
			"Total : "+String:C10(wpVar_o.totalCharge; "### ###,##0.00 €"); "")
		
		$ligne_o:=WP Table get rows:C1475($tableau_o; 2; $tableau_o.rowCount)
		WP SET ATTRIBUTES:C1342($ligne_o; wk font bold:K81:68; False:C215)
		
		$colonne_o:=WP Table get columns:C1476($tableau_o; 1; 2)
		WP SET ATTRIBUTES:C1342($colonne_o; wk text align:K81:49; wk right:K81:96)
		
		// Recherche des "Dettes"
		$element_c:=New collection:C1472
		$element_c:=WP Get elements:C1550($2->; wk type table:K81:222)
		
		$tableau_o:=WP Get element by ID:C1549($2->; "t13")
		
		For each ($dette_o; [HeBerge:4]situationBudgetaire:85.dette.detail)
			$row_o:=WP Table append row:C1474($tableau_o; $dette_o.lib; String:C10($dette_o.montant; "### ###,##0.00 €"); \
				String:C10($dette_o.montantMensuel; "### ###,##0.00 €"); String:C10($dette_o.dateFin))
		End for each 
		
		$row_o:=WP Table append row:C1474($tableau_o; ""; String:C10([HeBerge:4]situationBudgetaire:85.dette.detail.sum("montant"); "### ###,##0.00 €"); \
			String:C10([HeBerge:4]situationBudgetaire:85.dette.detail.sum("montantMensuel"); "### ###,##0.00 €"); "")
		
		$ligne_o:=WP Table get rows:C1475($tableau_o; 2; $tableau_o.rowCount)
		WP SET ATTRIBUTES:C1342($ligne_o; wk font bold:K81:68; False:C215)
		
		$colonne_o:=WP Table get columns:C1476($tableau_o; 2; 2)
		WP SET ATTRIBUTES:C1342($colonne_o; wk text align:K81:49; wk right:K81:96)
		
		//Mark: Situation comptable
	: ($chargeDataCase_t="Situation comptable")
		$liste_c:=New collection:C1472
		
		If ($contexte4D_b=True:C214)
			$liste_c:=liste_c.copy()
		End if 
		
		$element_c:=New collection:C1472
		$element_c:=WP Get elements:C1550($2->; wk type table:K81:222)
		
		$tableau_o:=WP Get element by ID:C1549($2->; "t8")
		
		For each ($element_o; $liste_c)
			$row_o:=WP Table append row:C1474($tableau_o; $element_o.datePiece; $element_o.numeroPiece; $element_o.typePiece; \
				$element_o.libelle; Choose:C955($element_o.debit>0; String:C10($element_o.debit; "### ###,##0.00 €"); ""); \
				Choose:C955($element_o.credit>0; String:C10($element_o.credit; "### ###,##0.00 €"); ""))
			
			If ($element_o.numeroPiece#"RC/@")  // Si la ligne traite une facture on aligne le libellé à droite
				$cellule_o:=WP Table get cells:C1477($tableau_o; 4; $tableau_o.rowCount)
				WP SET ATTRIBUTES:C1342($cellule_o; wk text align:K81:49; wk right:K81:96)
			End if 
			
		End for each 
		
		$colonne_o:=WP Table get columns:C1476($tableau_o; 5; 2)
		WP SET ATTRIBUTES:C1342($colonne_o; wk text align:K81:49; wk right:K81:96)
		
		$tableau_o:=WP Get element by ID:C1549($2->; "t1")
		$row_o:=WP Table append row:C1474($tableau_o; String:C10($liste_c.sum("debit"); "### ###,##0.00 €"); String:C10($liste_c.sum("credit"); \
			"### ###,##0.00 €"))
		
		WP TABLE DELETE ROWS:C1693($tableau_o; 1)
		wpVar_o.soldeRestantAPayer:=$liste_c.sum("debit")-$liste_c.sum("credit")
		
		//Mark: Facture participation
	: ($chargeDataCase_t="Facture participation")
		
		$element_c:=New collection:C1472
		$element_c:=WP Get elements:C1550($2->; wk type table:K81:222)
		
		$tableau_o:=WP Get element by ID:C1549($2->; "t3")
		
		While (Not:C34(End selection:C36([Factures_Lignes:87])))
			GES_Imp_Maj_Variables(->[Factures:86]; $modeleImpression_t)
			
			$row_o:=WP Table append row:C1474($tableau_o; txt_lig_libelle; String:C10([Factures_Lignes:87]FACL_Quantite:18); \
				String:C10([Factures_Lignes:87]FACL_Prix_Unit_TTC:16; "### ###,##0.00 €"); String:C10([Factures_Lignes:87]FACL_Montant_TTC:12; "### ###,##0.00 €"))
			NEXT RECORD:C51([Factures_Lignes:87])
		End while 
		
		$colonne_o:=WP Table get columns:C1476($tableau_o; 2; 3)
		WP SET ATTRIBUTES:C1342($colonne_o; wk text align:K81:49; wk right:K81:96)
		
		WP TABLE DELETE ROWS:C1693($tableau_o; 2)
	: ($docwpro_e#Null:C1517)
		SOC_Get_Config
		
		// Recherche de l'hébergé
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=Num:C11(w_visiteur.hebergeID))
		
		// Recherche de l'hébergement
		RELATE ONE SELECTION:C349([HeBerge:4]; [HeberGement:5])
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
End case 