Class extends Entity

Function update($date_d : Date; $commentaire_t : Text; $dette_c : Collection; $nbPersonneMenage_el : Integer; $modefacturation : Text)->$statut_o : Object
	
	This:C1470.date:=$date_d
	This:C1470.commentaire:=$commentaire_t
	This:C1470.dette:=New object:C1471("detail"; $dette_c)
	This:C1470.nbPersonneMenage:=$nbPersonneMenage_el
	
	$statut_o:=This:C1470.save()