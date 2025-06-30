//Script b_ActionRAZ
CONFIRM:C162("Note 'Actions' : remettre à zéro les données de la note Action sur : "+String:C10(Records in table:C83([HeBerge:4]))+" fiche(s).")
If (OK=1)
	MESSAGES ON:C181
	READ WRITE:C146([HeBerge:4])
	ALL RECORDS:C47([HeBerge:4])
	APPLY TO SELECTION:C70([HeBerge:4]; [HeBerge:4]HG_Actions:40:="")
	READ ONLY:C145([HeBerge:4])
	MESSAGES OFF:C175
	BEEP:C151
End if 