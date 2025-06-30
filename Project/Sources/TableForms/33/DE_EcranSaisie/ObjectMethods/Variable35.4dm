
If (F_ChampObligatoire(<>vlSTR_DE-<>vlSTR)=False:C215)
	REJECT:C38
Else 
	P_DS_SaveNotes
	P_DS_SavePrescription(1)
End if 