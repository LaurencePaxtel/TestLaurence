CONFIRM:C162("Veuillez confirmer la suppression"; "Oui"; "annuler")
If (OK=1)
	DELETE RECORD:C58([Maraude:24])
	P_MaraudeVeilleFind
End if 