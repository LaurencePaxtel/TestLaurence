var $mois_el; $annee_el : Integer

If (Form:C1466.forceEnvoi=False:C215)
	$mois_el:=Month of:C24(outilsPremierDuMois(Current date:C33)-1)
	$annee_el:=Year of:C25(outilsPremierDuMois(Current date:C33)-1)
	
	CONFIRM:C162("Voulez-vous vraiment forcer la réactualisation du montant en retard des APL pour la période du "+String:C10($mois_el)+"/"+String:C10($annee_el)+" ?"; "Oui"; "Non")
	Form:C1466.forceEnvoi:=(OK=1)
End if 