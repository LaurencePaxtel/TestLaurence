var $position_t : Text

$position_t:="center"

$retroCompatibilite_c:=New collection:C1472
$retroCompatibilite_c.push(New object:C1471("titre"; "Recalcul des âges"; "entree"; 1))
$retroCompatibilite_c.push(New object:C1471("titre"; "Transformer notes vers nouveau format"; "entree"; 2))
$retroCompatibilite_c.push(New object:C1471("titre"; "Reformatage au sein des nouvelles notes de note qui contiennent du code HTML"; "entree"; 3))
$retroCompatibilite_c.push(New object:C1471("titre"; "Calcul de la première date de contact"; "entree"; 4))
$retroCompatibilite_c.push(New object:C1471("titre"; "Regénération du mois et de l'année pour les factures"; "entree"; 5))
$retroCompatibilite_c.push(New object:C1471("titre"; "Report Autre solution"; "entree"; 6))
$retroCompatibilite_c.push(New object:C1471("titre"; "TimeStamp pour fiche hébergement"; "entree"; 7))
$retroCompatibilite_c.push(New object:C1471("titre"; "Génération de la situation budgetaire"; "entree"; 8))
$retroCompatibilite_c.push(New object:C1471("titre"; "Mise en place de la date d'origine"; "entree"; 9))
$retroCompatibilite_c.push(New object:C1471("titre"; "Reformatage du champ [HeBerge]HB_Clé avec date de naissance sous 4 chiffres"; "entree"; 11))
$retroCompatibilite_c.push(New object:C1471("titre"; "Ajout de la propriété importApplicationMobile dans les notes"; "entree"; 12))
$retroCompatibilite_c.push(New object:C1471("titre"; "Externalisation de la gestion des privilèges pour les intervenants"; "entree"; 13))
$retroCompatibilite_c.push(New object:C1471("titre"; "Correction champ [Structure_User]Ref_Structure"; "entree"; 14))
$retroCompatibilite_c.push(New object:C1471("titre"; "Dé-doublonnage table [Adresses]"; "entree"; 15))
$retroCompatibilite_c.push(New object:C1471("titre"; "Externalisation de la gestion des mots de passe pour les intervenants"; "entree"; 16))
$retroCompatibilite_c.push(New object:C1471("titre"; "Affectation catégorie \"location\" au facture de location"; "entree"; 17))
$retroCompatibilite_c.push(New object:C1471("titre"; "Externalisation du champ [HeBerge]situationBudgetaire en table [ParticipationsWebBudget] et [ParticipationsWebDette]"; "entree"; 18))
$retroCompatibilite_c.push(New object:C1471("titre"; "Transformation champ [Messagerie]MS_User"; "entree"; 19))
$retroCompatibilite_c.push(New object:C1471("titre"; "Maintenance participation web"; "entree"; 20))
$retroCompatibilite_c.push(New object:C1471("titre"; "Maintenance dette initiale"; "entree"; 21))
$retroCompatibilite_c.push(New object:C1471("titre"; "Maraude vers date d'entrée et sortie"; "entree"; 22))

outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; $retroCompatibilite_c; \
"property"; "titre"; "selectSubTitle"; "Merci de sélectionner la rétroactivité souhaitée"; "title"; "Choix de la rétroactivité :"))

If (selectValue_t#"")
	$retroCompatibilite_c:=$retroCompatibilite_c.query("titre = :1"; selectValue_t)
	
	If ($retroCompatibilite_c.length=1)
		CONFIRM:C162("Souhaitez-vous vraiment appliquer l'effet rétroactif « "+selectValue_t+" »"; "Oui"; "Non")
		
		If (OK=1)
			outilsPaxtelRetroactif($retroCompatibilite_c[0].entree)
		End if 
		
	End if 
	
End if 