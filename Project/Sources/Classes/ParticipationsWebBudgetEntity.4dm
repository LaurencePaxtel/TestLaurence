Class extends Entity

Function update($salaire_r : Real; $loyer_r : Real; $apl_r : Real; $ressource_c : Collection; $charge_c : Collection; $forfaitParticipation_r : Real; $totalParticipation_r : Real)->$statut_o : Object
/*var $totalRessource_r; $totalCharge_r : Real
	
This.salaire:=$salaire_r
This.loyer:=$loyer_r
This.apl:=$apl_r
	
This.ressource:=Créer objet("detail"; $ressource_c)
This.charge:=Créer objet("detail"; $charge_c)
	
This.forfaitParticipation:=$forfaitParticipation_r
This.totalParticipation:=$totalParticipation_r
	
$totalRessource_r:=This.salaire+This.ressource.detail.sum("value")+This.apl
$totalCharge_r:=This.loyer+This.charge.detail.sum("value")
	
This.resteAVivre:=$totalRessource_r-$totalCharge_r
	
Si ($totalRessource_r-This.apl>0)
This.tauxEffortLoyer:=Arrondi((This.loyer*100)/($totalRessource_r-This.apl); 2)
Sinon 
This.tauxEffortLoyer:=0
Fin de si 
	
Si ($totalRessource_r>0)
This.tauxEndettement:=Arrondi(($totalCharge_r*100)/$totalRessource_r; 2)
Sinon 
This.tauxEndettement:=0
Fin de si 
	
$statut_o:=This.save()
*/