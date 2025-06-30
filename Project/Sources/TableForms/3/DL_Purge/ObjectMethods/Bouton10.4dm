//Script b_Action22
CONFIRM:C162("Suppression de la fiche de paramètres du report automatique sur serveur"+Char:C90(13)+"Confirmez-vous ?")
If (OK=1)
	DébutInitReportAuto(-1)
	BEEP:C151
End if 