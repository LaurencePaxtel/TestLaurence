If (Form event code:C388=Sur clic:K2:4)
	$vb_OK:=True:C214
	If (ta_ChampsCode{ta_Champs}="T")
		va_Libellé:=Table name:C256(tp_Champs{ta_Champs})
	Else 
		$vb_OK:=(va_Libellé>"")
	End if 
	If ($vb_OK)
		If (Find in field:C653([ReferenceUnique:2]RU_Fichier:2; va_Libellé)#-1)
			StrAlerte(11; va_Libellé)
		Else 
			READ WRITE:C146([ReferenceUnique:2])
			CREATE RECORD:C68([ReferenceUnique:2])
			[ReferenceUnique:2]RU_Fichier:2:=va_Libellé
			[ReferenceUnique:2]RU_Numero:3:=1
			[ReferenceUnique:2]RU_ValeurApha:4:=""
			SAVE RECORD:C53([ReferenceUnique:2])
			UNLOAD RECORD:C212([ReferenceUnique:2])
			READ ONLY:C145([ReferenceUnique:2])
		End if 
	Else 
		StrAlerte(61; "")
	End if 
End if 