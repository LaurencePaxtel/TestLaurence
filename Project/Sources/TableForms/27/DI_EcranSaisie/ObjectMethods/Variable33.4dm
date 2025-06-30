If (F_ChampObligatoire(<>vlSTR_DI-<>vlSTR)=False:C215)
	REJECT:C38
Else 
	SAVE RECORD:C53([DossierInfirmie:27])
End if 