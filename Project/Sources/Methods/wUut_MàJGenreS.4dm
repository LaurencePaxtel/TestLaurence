//%attributes = {}

READ WRITE:C146([HeberGement:5])
ALL RECORDS:C47([HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])
If (Records in selection:C76([HeBerge:4])>0)
	MESSAGES ON:C181
	FIRST RECORD:C50([HeBerge:4])
	Repeat 
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
		If (Records in selection:C76([HeberGement:5])>0)
			APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Genre:96:=[HeBerge:4]HG_Genre:39)
		End if 
		NEXT RECORD:C51([HeBerge:4])
	Until (End selection:C36([HeBerge:4]))
	MESSAGES OFF:C175
	BEEP:C151
	BEEP:C151
End if 
READ ONLY:C145([HeberGement:5])