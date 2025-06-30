Class extends Entity

Function civilite()->$civilite_t : Text
	var $hebergement_es : cs:C1710.HeberGementSelection
	
	$hebergement_es:=This:C1470.HB_ReferenceID_1_HG_HB_ID
	
	If ($hebergement_es.length>0)
		$civilite_t:=Choose:C955($hebergement_es[0].HG_EtatCivil="@Homme@"; "Monsieur"; "Madame")
	End if 
	
Function fullName()->$fullName_t : Text
	$fullName_t:=This:C1470.HB_Nom+" "+This:C1470.HB_Prénom
	
Function isFamChief()->$isFamChief_b : Boolean
	var $hebergement_es : cs:C1710.HeberGementSelection
	
	$hebergement_es:=This:C1470.HB_ReferenceID_1_HG_HB_ID.orderBy("HG_Date desc, HG_HeureAppel desc")
	
	If ($hebergement_es.length>0)
		$isFamChief_b:=$hebergement_es[0].HG_FamChef
	Else 
		$isFamChief_b:=True:C214
	End if 
	
Function initSituationBudget()
	var $statut_o : Object
	
	This:C1470.situationBudgetaire:=New object:C1471
	
	This:C1470.situationBudgetaire.dateSitBudget:=!00-00-00!
	This:C1470.situationBudgetaire.nbPersonneMenage:=1
	This:C1470.situationBudgetaire.commentaire:=""
	
	This:C1470.situationBudgetaire.budget:=New object:C1471
	
	This:C1470.situationBudgetaire.budget.salaire:=0
	This:C1470.situationBudgetaire.budget.loyer:=0
	This:C1470.situationBudgetaire.budget.apl:=0
	
	This:C1470.situationBudgetaire.budget.charge:=New collection:C1472
	This:C1470.situationBudgetaire.budget.ressource:=New collection:C1472
	
	This:C1470.situationBudgetaire.dette:=New object:C1471
	This:C1470.situationBudgetaire.dette.detail:=New collection:C1472
	
	$statut_o:=This:C1470.save()
	
Function getSituationComptableList()->$liste_c : Collection
	var $index_el : Integer
	var $facture_o : Object
	
	var $facture_c; $reglement_c; $listeB_c : Collection
	
	var $facture_es : cs:C1710.FacturesSelection
	
	var $reglement_e : cs:C1710.ReglementsEntity
	var $reglement_es : cs:C1710.ReglementsSelection
	
	$liste_c:=New collection:C1472
	$listeB_c:=New collection:C1472
	
	$reglement_c:=New collection:C1472
	
	// Recherche de toutes les fatures de l'hébergé
	$facture_es:=ds:C1482.Factures.query("FAC_Origine_ID = :1"; This:C1470.HB_ReferenceID)
	$facture_es:=$facture_es.orderBy("FAC_Destinataire_Nom asc, FAC_Annee asc, FAC_Mois asc")
	
	$listeB_c:=$facture_es.toCollection()
	$facture_c:=$listeB_c.copy()
	
	For each ($facture_o; $facture_c)
		$index_el:=$listeB_c.indices("ID = :1"; $facture_o.ID)[0]
		$reglement_es:=ds:C1482.Reglements.query("REG_Origine_IDS = :1"; "@"+String:C10($facture_o.ID)+"@").orderBy("REG_Date_Piece asc")
		
		For each ($reglement_e; $reglement_es)
			
			If ($reglement_c.indexOf($reglement_e.ID)=-1)
				$reglement_c.push($reglement_e.ID)
				$listeB_c.insert($index_el+1; New object:C1471("reglement"; $reglement_e))
			End if 
			
		End for each 
		
	End for each 
	
	For each ($element_o; $listeB_c)
		$liste_c.push(New object:C1471())
		
		If ($element_o.FAC_Origine_ID#Null:C1517)  // C'est une facture
			$liste_c[$liste_c.length-1].datePiece:=$element_o.FAC_Date_Piece
			
			$liste_c[$liste_c.length-1].typePiece:=Choose:C955($element_o.FAC_Avoir_ID>0; "Avoir"; "Facture")
			$liste_c[$liste_c.length-1].numeroPiece:=$element_o.FAC_No_Piece
			
			$liste_c[$liste_c.length-1].libelle:=Choose:C955($element_o.FAC_Avoir_ID>0; Replace string:C233($element_o.FAC_No_Piece; "AV"; "FAC"); $element_o.FAC_Mois_Annee)
			
			$liste_c[$liste_c.length-1].debit:=Choose:C955($element_o.FAC_Avoir_ID>0; 0; $element_o.FAC_Montant_TTC)
			$liste_c[$liste_c.length-1].credit:=Choose:C955($element_o.FAC_Avoir_ID>0; $element_o.FAC_Montant_TTC; 0)
		Else   // C'est un règlement
			$liste_c[$liste_c.length-1].datePiece:=$element_o.reglement.REG_Date_Piece
			
			$liste_c[$liste_c.length-1].typePiece:="Règlement"
			$liste_c[$liste_c.length-1].numeroPiece:=$element_o.reglement.REG_No_Piece
			
			$liste_c[$liste_c.length-1].libelle:=$element_o.reglement.REG_Mode_Reglement
			
			$liste_c[$liste_c.length-1].debit:=0
			$liste_c[$liste_c.length-1].credit:=$element_o.reglement.REG_Montant
		End if 
		
	End for each 