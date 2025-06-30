//b_ValHBnewGpe
If (Form event code:C388=Sur clic:K2:4)
	
	LOAD RECORD:C52([GrouPe:36])  // #BS MIGRATION 15/06/16
	
	If (F_HébergementGroupeNew(b_ValHBnewGpe=1))
		CANCEL:C270
	End if 
End if 