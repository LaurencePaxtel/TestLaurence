//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 24/05/23, 17:50:09
// ----------------------------------------------------
// Méthode : outilsWebHebergeSitBjtAjax
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $data_t : Text
var $index_el : Integer
var $retour_o; $chargeLib_o; $ressourceLib_o; $detteLib_o; $statut_o : Object
var $data_c; $recapBudget_c; $dette_c; $chargeLib_c; $chargeValue_c; $ressourceLib_c; $ressourceValue_c; $detteLib_c; $detteMontant_c; $dettePlanApurement_c; $detteDuree_c; \
$detteDateDebut_c; $detteDateFin_c; $detteMontantMensuel_c; $detteArretAvantTerme_c; $detteDateDerniereMensualite_c; \
$detteMontantRestant_c : Collection

var $heberge_e : cs:C1710.HeBergeEntity

$retour_o:=New object:C1471

outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; Num:C11(w_visiteur.hebergeID); ->$heberge_e; "first")

Case of 
	: (w_visiteur.action="chargeBudget")
		outilsWebSendData(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; ->[HeBerge:4]situationBudgetaire:85; ->$data_t)
		$retour_o.data:=$data_t
	: (w_visiteur.action="saveBudget")
		$data_c:=JSON Parse:C1218(w_visiteur.data)
		
		$recapBudget_c:=$data_c.query("table = :1"; "tableRecapBudgetaire")
		$dette_c:=$data_c.query("table = :1"; "tableDette")
		
		$heberge_e.situationBudgetaire:=New object:C1471
		
		$heberge_e.situationBudgetaire.dateSitBudget:=Date:C102(String:C10(w_visiteur.date))
		$heberge_e.situationBudgetaire.nbPersonneMenage:=Num:C11(String:C10(w_visiteur.nbPersonneMenage))
		$heberge_e.situationBudgetaire.modeFacturation:=String:C10(w_visiteur.modeFacturation)
		$heberge_e.situationBudgetaire.commentaire:=String:C10(w_visiteur.commentaire)
		
		$heberge_e.situationBudgetaire.budget:=New object:C1471
		
		$heberge_e.situationBudgetaire.budget.salaire:=0
		$heberge_e.situationBudgetaire.budget.loyer:=0
		$heberge_e.situationBudgetaire.budget.apl:=0
		
		If ($recapBudget_c[0].data.query("lib=:1"; "salaireValue").length>0)
			$heberge_e.situationBudgetaire.budget.salaire:=Num:C11(Replace string:C233($recapBudget_c[0].data.query("lib=:1"; "salaireValue")[0].value; "."; ","))
		End if 
		
		If ($recapBudget_c[0].data.query("lib=:1"; "loyerValue").length>0)
			$heberge_e.situationBudgetaire.budget.loyer:=Num:C11(Replace string:C233($recapBudget_c[0].data.query("lib=:1"; "loyerValue")[0].value; "."; ","))
		End if 
		
		If ($recapBudget_c[0].data.query("lib=:1"; "aplValue").length>0)
			$heberge_e.situationBudgetaire.budget.apl:=Num:C11(Replace string:C233($recapBudget_c[0].data.query("lib=:1"; "aplValue")[0].value; "."; ","))
		End if 
		
		$heberge_e.situationBudgetaire.budget.charge:=New collection:C1472
		$heberge_e.situationBudgetaire.budget.ressource:=New collection:C1472
		
		$chargeLib_c:=$recapBudget_c[0].data.query("lib = :1"; "chargeLib")
		$chargeValue_c:=$recapBudget_c[0].data.query("lib = :1"; "chargeValue")
		
		For each ($chargeLib_o; $chargeLib_c)
			$index_el:=$chargeLib_c.indexOf($chargeLib_o)
			
			$heberge_e.situationBudgetaire.budget.charge.push(New object:C1471(\
				"lib"; $chargeLib_o.value; \
				"value"; Num:C11(Replace string:C233($chargeValue_c[$index_el].value; "."; ","))))
		End for each 
		
		$ressourceLib_c:=$recapBudget_c[0].data.query("lib = :1"; "ressourceLib")
		$ressourceValue_c:=$recapBudget_c[0].data.query("lib = :1"; "ressourceValue")
		
		For each ($ressourceLib_o; $ressourceLib_c)
			$index_el:=$ressourceLib_c.indexOf($ressourceLib_o)
			
			If ($ressourceLib_o.value#"APL@")
				$heberge_e.situationBudgetaire.budget.ressource.push(New object:C1471(\
					"lib"; $ressourceLib_o.value; \
					"value"; Num:C11(Replace string:C233($ressourceValue_c[$index_el].value; "."; ","))))
			End if 
			
		End for each 
		
		$heberge_e.situationBudgetaire.dette:=New object:C1471
		$heberge_e.situationBudgetaire.dette.detail:=New collection:C1472
		
		$detteLib_c:=$dette_c[0].data.query("lib = :1"; "detteLib")
		$detteMontant_c:=$dette_c[0].data.query("lib = :1"; "detteMontant")
		$dettePlanApurement_c:=$dette_c[0].data.query("lib = :1"; "dettePlanApurement")
		$detteDuree_c:=$dette_c[0].data.query("lib = :1"; "detteDuree")
		$detteDateDebut_c:=$dette_c[0].data.query("lib = :1"; "detteDateDebut")
		$detteDateFin_c:=$dette_c[0].data.query("lib = :1"; "detteDateFin")
		$detteMontantMensuel_c:=$dette_c[0].data.query("lib = :1"; "detteMontantMensuel")
		$detteArretAvantTerme_c:=$dette_c[0].data.query("lib = :1"; "detteArretAvantTerme")
		$detteDateDerniereMensualite_c:=$dette_c[0].data.query("lib = :1"; "detteDateDerniereMensualite")
		$detteMontantRestant_c:=$dette_c[0].data.query("lib = :1"; "detteMontantRestant")
		
		For each ($detteLib_o; $detteLib_c)
			$index_el:=$detteLib_c.indexOf($detteLib_o)
			
			$heberge_e.situationBudgetaire.dette.detail.push(New object:C1471(\
				"lib"; $detteLib_o.value; \
				"montant"; Num:C11(Replace string:C233($detteMontant_c[$index_el].value; "."; ",")); \
				"planApurement"; $dettePlanApurement_c[$index_el].value; \
				"duree"; Num:C11(Replace string:C233($detteDuree_c[$index_el].value; "."; ",")); \
				"dateDebut"; Date:C102(String:C10($detteDateDebut_c[$index_el].value)); \
				"dateFin"; Date:C102(String:C10($detteDateFin_c[$index_el].value)); \
				"montantMensuel"; Num:C11(Replace string:C233($detteMontantMensuel_c[$index_el].value; "."; ",")); \
				"arretAvantTerme"; $detteArretAvantTerme_c[$index_el].value; \
				"dateDerniereMensualite"; Date:C102(String:C10($detteDateDerniereMensualite_c[$index_el].value)); \
				"montantRestant"; Num:C11(Replace string:C233($detteMontantRestant_c[$index_el].value; "."; ","))))
		End for each 
		
		$statut_o:=$heberge_e.save()
End case 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))