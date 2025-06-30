var $position_t : Text
var $heberge_e : cs:C1710.HeBergeEntity

$position_t:="center"

$retroCompatibilite_c:=New collection:C1472
$retroCompatibilite_c.push(New object:C1471("titre"; "Recalcul des âges"; "entree"; 1))
$retroCompatibilite_c.push(New object:C1471("titre"; "Calcul de la première date de contact"; "entree"; 4))
$retroCompatibilite_c.push(New object:C1471("titre"; "Report Autre solution"; "entree"; 6))
$retroCompatibilite_c.push(New object:C1471("titre"; "Mise en place de la date d'origine"; "entree"; 9))

outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; $retroCompatibilite_c; \
"property"; "titre"; "selectSubTitle"; "Merci de sélectionner la rétroactivité souhaitée"; "title"; "Choix de la rétroactivité :"))

If (selectValue_t#"")
	$retroCompatibilite_c:=$retroCompatibilite_c.query("titre = :1"; selectValue_t)
	
	If ($retroCompatibilite_c.length=1)
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]ID:65>0)
			$heberge_e:=ds:C1482.HeBerge.get([HeBerge:4]ID:65)
			CONFIRM:C162("Souhaitez-vous vraiment appliquer l'effet rétroactif « "+selectValue_t+" » à "+$heberge_e.fullName(); "Oui"; "Non")
			
			If (OK=1)
				outilsPaxtelRetroactif($retroCompatibilite_c[0].entree; $heberge_e)
			End if 
			
		Else 
			StrAlerte(2; "")
		End if 
		
	End if 
	
End if 