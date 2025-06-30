var $keyLinkFam_t : Text
var $statut_o : Object

CONFIRM:C162("Souhaitez-vous vraiment générer une nouvelle clé de lien famille (cette opération est irréversible) ?"; "Oui"; "Non")

If (OK=1)
	outilsHebergeLoadRecord
	
	If ([HeBerge:4]ID:65>0)
		$heberge_e:=ds:C1482.HeBerge.get([HeBerge:4]ID:65)
		
		$keyLinkFam_t:=<>va_T_Site+String:C10(outilsHebergeGenKeyLinkFam(False:C215; False:C215; 0))
		ALERT:C41("La nouvelle clé de lien de famille pour l'hébergé "+[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4+" est la suivante : "+$keyLinkFam_t)
		
		$heberge_e.HB_CléFam:=$keyLinkFam_t
		$statut_o:=$heberge_e.save()
	End if 
	
End if 