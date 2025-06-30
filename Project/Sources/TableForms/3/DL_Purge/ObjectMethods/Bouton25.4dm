If (Records in selection:C76([HeBerge:4])>0)
	If (i_Confirmer("Affectation de la date de création de l'hébergé en fonction de la date"+" de la première fiche d'hébergement."))
		READ WRITE:C146([HeBerge:4])
		APPLY TO SELECTION:C70([HeBerge:4]; wUut_MàJFicheCreeeHébergé)
		READ ONLY:C145([HeBerge:4])
	End if 
Else 
	ALERT:C41("Aucune fiche d'hébergé dans la liste !")
End if 