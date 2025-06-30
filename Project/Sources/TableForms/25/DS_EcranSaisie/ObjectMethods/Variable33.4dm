If (F_ChampObligatoire(<>vlSTR_DS-<>vlSTR)=False:C215)
	REJECT:C38
Else 
	SAVE RECORD:C53([DossierSocial:25])
End if 