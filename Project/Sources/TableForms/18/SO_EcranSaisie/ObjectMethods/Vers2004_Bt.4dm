If (Form event code:C388=Sur clic:K2:4)
	SAVE RECORD:C53([SOciete:18])
	P_StatistiqueNotes(0; <>ve_Coordination; ->[SOciete:18]SO_CléSite:10)
	ALERT:C41("Mise à jour confirmée .")
End if 