
CONFIRM:C162("Confirmez vous la mise à jour du champ Durée"+" de la rencontre de la maraude?")
If (OK=1)
	QUERY:C277([Maraude:24])
	If (OK=1)
		CONFIRM:C162("Confirmez vous la mise à jour du champ Durée"+Char:C90(13)+String:C10(Records in selection:C76([Maraude:24]))+"parmi"+String:C10(Records in table:C83([Maraude:24]))+"fiche(s)")
		If (OK=1)
			MESSAGES ON:C181
			READ WRITE:C146([Maraude:24])
			APPLY TO SELECTION:C70([Maraude:24]; wUut_MàJDuréeRen)
			UNLOAD RECORD:C212([Maraude:24])
			READ ONLY:C145([Maraude:24])
		End if 
	End if 
End if 