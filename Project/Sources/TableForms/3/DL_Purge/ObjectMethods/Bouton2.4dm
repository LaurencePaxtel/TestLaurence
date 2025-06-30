//Script b_115
CONFIRM:C162("Confirmez vous la mise à zero du priorité ?")
If (OK=1)
	MESSAGES ON:C181
	ALL RECORDS:C47([HeberGement:5])
	MultiSoc_Filter(->[HeberGement:5])
	If (Records in selection:C76([HeberGement:5])>0)
		READ WRITE:C146([HeberGement:5])
		APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Priorité:57:=0)
		UNLOAD RECORD:C212([HeberGement:5])
		READ ONLY:C145([HeberGement:5])
	End if 
End if 