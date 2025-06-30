Class extends DataClass

Function searchAndCreateRecordIfDontExist($hebergeID_el : Integer; $annee_el : Integer; $mois_el : Integer; $salaire_r : Real; $loyer_r : Real; $apl_r : Real; $ressource_c : Collection; $charge_c : Collection; $commentaire_t : Text; $nbPersonneMenage_el : Integer; $refStructure_t : Text)->$participationWebBudget_e : cs:C1710.ParticipationsWebBudgetEntity
/*var $totalRessource_r; $totalCharge_r : Real
var $statut_o : Object
	
var $participationWebBudget_es : cs.ParticipationsWebBudgetSelection
	
$participationWebBudget_es:=ds.ParticipationsWebBudget.query("hebergeID = :1 AND annee = :2 AND mois = :3"; $hebergeID_el; $annee_el; $mois_el)
	
Au cas ou 
: ($participationWebBudget_es.length>1)  // Pas normal de se retrouver dans ce cas
TRACE
: ($participationWebBudget_es.length=1)
$participationWebBudget_e:=$participationWebBudget_es[0]
Sinon   // Création de la fiche [ParticipationsWebBudget]
$participationWebBudget_e:=ds.ParticipationsWebBudget.new()
$participationWebBudget_e.hebergeID:=$hebergeID_el
$participationWebBudget_e.annee:=$annee_el
$participationWebBudget_e.mois:=$mois_el
$participationWebBudget_e.salaire:=$salaire_r
$participationWebBudget_e.loyer:=$loyer_r
$participationWebBudget_e.apl:=$apl_r
$participationWebBudget_e.ressource:=Créer objet("detail"; $ressource_c)
$participationWebBudget_e.charge:=Créer objet("detail"; $charge_c)
$participationWebBudget_e.commentaire:=$commentaire_t
$participationWebBudget_e.nbPersonneMenage:=$nbPersonneMenage_el
	
Si ($participationWebBudget_e.nbPersonneMenage=0)
$participationWebBudget_e.nbPersonneMenage:=1
Fin de si 
	
$totalRessource_r:=$participationWebBudget_e.salaire+$participationWebBudget_e.ressource.detail.sum("value")+$participationWebBudget_e.apl
$totalCharge_r:=$participationWebBudget_e.loyer+$participationWebBudget_e.charge.detail.sum("value")
	
$participationWebBudget_e.resteAVivre:=$totalRessource_r-$totalCharge_r
	
Si ($totalRessource_r-$participationWebBudget_e.apl>0)
$participationWebBudget_e.tauxEffortLoyer:=Arrondi(($participationWebBudget_e.loyer*100)/($totalRessource_r-$participationWebBudget_e.apl); 2)
Fin de si 
	
Si ($totalRessource_r>0)
$participationWebBudget_e.tauxEndettement:=Arrondi(($totalCharge_r*100)/$totalRessource_r; 2)
Fin de si 
	
$participationWebBudget_e.Ref_Structure:=$refStructure_t
	
$statut_o:=$participationWebBudget_e.save()
Fin de cas 
*/