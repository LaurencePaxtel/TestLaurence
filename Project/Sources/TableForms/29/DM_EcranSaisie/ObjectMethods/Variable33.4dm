If (F_ChampObligatoire(<>vlSTR_DM-<>vlSTR)=False:C215)
	REJECT:C38
Else 
	SAVE RECORD:C53([DossierMedical:29])
End if 