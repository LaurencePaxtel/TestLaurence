LOAD RECORD:C52([TAbles:12])

If ([TAbles:12]TB_RéférenceID:1>0)
	FORM SET INPUT:C55([TAbles:12]; "TA_EcranSaisie")
	MODIFY RECORD:C57([TAbles:12]; *)
Else 
	StrAlerte(22; "")
End if 