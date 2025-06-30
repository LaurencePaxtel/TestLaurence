Class extends Entity


Function get FAC_Solde_Anterieur_cal() : Real
	var factures_e : cs:C1710.FacturesEntity
	var facture_es : cs:C1710.FacturesSelection
	var $heberge_e : cs:C1710.HeBergeEntity
	
	// Si c'est un avoir, il n'y a pas de solde antérieur.
	If (This:C1470.FAC_Type="Avoir")
		return 0
	End if 
	
	factures_e:=ds:C1482.Factures.query("FAC_Locataire_ID = :1"; This:C1470.FAC_Locataire_ID).orderBy("FAC_Annee, FAC_Mois").first()
	
	If (factures_e.FAC_Annee=This:C1470.FAC_Annee) && (factures_e.FAC_Mois=This:C1470.FAC_Mois)
		// C'est la premiere facture.
		$heberge_e:=ds:C1482.HeBerge.get(This:C1470.FAC_Locataire_ID)
		If ($heberge_e#Null:C1517)
			return $heberge_e.HB_FAC_Dette_Initiale
		End if 
		
	Else 
/*
facture_es:=ds.Factures.query("FAC_Locataire_ID is :1 AND FAC_Periode_Au < :2 AND FAC_Periode_Au # :3"; This.FAC_Locataire_ID; This.FAC_Periode_Du; !00/00/0000!).orderBy("FAC_Periode_Du")
		
var $solde_r : Real
		
Pour chaque (facture_e; facture_es)
Si (facture_e.indexOf(facture_es)=0)
$heberge_e:=ds.HeBerge.get(This.FAC_Locataire_ID)
		
$solde_r:=($heberge_e#Null) ? $heberge_e.HB_FAC_Dette_Initiale : 0
		
Sinon 
$solde_r+=facture_e.FAC_Montant_TTC-This.FAC_Solde_Regle
Fin de si 
Fin de chaque 
		
return $solde_r
*/
		
		// Ce n'est pas la premiere facture du locataire.
		facture_es:=ds:C1482.Factures.query("FAC_Locataire_ID is :1 AND FAC_Periode_Au < :2 AND FAC_Periode_Au # :3"; This:C1470.FAC_Locataire_ID; This:C1470.FAC_Periode_Du; !00-00-00!).orderBy("FAC_Periode_Du desc")
		
		If (facture_es.length#0)
			return facture_es.first().FAC_Solde_Du_cal
		End if 
		
	End if 
	
	return 0
	
	
Function get FAC_Net_A_Payer_cal() : Real
	
	// Si c'est un avoir, il n'y a pas de net à payer.
	If (This:C1470.FAC_Type="Avoir")
		return This:C1470.FAC_Montant_TTC
	End if 
	
	return assurNum(This:C1470.FAC_Montant_TTC+This:C1470.FAC_Solde_Anterieur_cal)
	
	
	
Function get FAC_Solde_Du_cal()->$soldeDu_r : Real
/*
// Si c'est un avoir, il n'y a pas de solde dû.
Si (This.FAC_Type="Avoir")
return 0
Fin de si 
	
$soldeDu_r:=assurNum(This.FAC_Net_A_Payer_cal-This.FAC_Solde_Regle)
	
// S'il y a des avoirs qui sont liées à la facture il faut les prendre en compte dans le solde du
$avoir_es:=ds.Factures.query("FAC_Avoir_ID = :1"; This.ID)
Si ($avoir_es.length#0)
$soldeDu_r+=assurNum($avoir_es.sum("FAC_Montant_TTC"))
Fin de si 
*/
	
	var $montantTotalTTC_r : Real
	var $heberge_e : cs:C1710.HeBergeEntity
	// Dette initial
	$heberge_e:=ds:C1482.HeBerge.get(This:C1470.FAC_Locataire_ID)
	If ($heberge_e#Null:C1517)
		$montantTotalTTC_r:=$heberge_e.HB_FAC_Dette_Initiale
	End if 
	
	//Sommes des factures
	facture_es:=ds:C1482.Factures.query("FAC_Locataire_ID is :1 AND FAC_Periode_Du <= :2 AND FAC_Periode_Du # :3"; This:C1470.FAC_Locataire_ID; This:C1470.FAC_Periode_Du; !00-00-00!)
	$montantTotalTTC_r+=facture_es.sum("FAC_Montant_TTC")
	
	//Sommes des reglements du locataire
	$montantReglement_r:=ds:C1482.Reglements.query("REG_Locataire_ID IS :1"; This:C1470.FAC_Locataire_ID).sum("REG_Montant")
	
	If ($montantReglement_r>=$montantTotalTTC_r)
		return 0
	Else 
		return $montantTotalTTC_r-$montantReglement_r
	End if 
	
	
	
Function solde_du_a_date($dateMax_d : Date)->$soldeDu_r : Real
	
	var $montantTotalTTC_r : Real
	
	// Dette initial
	$heberge_e:=ds:C1482.HeBerge.get(This:C1470.FAC_Locataire_ID)
	If ($heberge_e#Null:C1517)
		$montantTotalTTC_r:=$heberge_e.HB_FAC_Dette_Initiale
	End if 
	
	//Sommes des factures
	facture_es:=ds:C1482.Factures.query("FAC_Locataire_ID is :1 AND FAC_Periode_Du <= :2 AND FAC_Periode_Du # :3"; This:C1470.FAC_Locataire_ID; $dateMax_d; !00-00-00!)
	$montantTotalTTC_r+=facture_es.sum("FAC_Montant_TTC")
	
	//Sommes des reglements du locataire
	$montantReglement_r:=ds:C1482.Reglements.query("REG_Locataire_ID IS :1 AND REG_Date_Piece <= :2 AND REG_Date_Piece # :3"; This:C1470.FAC_Locataire_ID; $dateMax_d; !00-00-00!).sum("REG_Montant")
	return $montantTotalTTC_r-$montantReglement_r
	