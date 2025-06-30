If (F_ChampObligatoire(<>vlSTR_DY-<>vlSTR)=False:C215)
	REJECT:C38
Else 
	SAVE RECORD:C53([DossierPsycho:28])
End if 