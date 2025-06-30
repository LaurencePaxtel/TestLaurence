//%attributes = {}
ALL RECORDS:C47([HeberGement:5])
MultiSoc_Filter(->[HeberGement:5])
If (Records in selection:C76([HeberGement:5])>0)
	MESSAGES ON:C181
	READ WRITE:C146([HeberGement:5])
	FIRST RECORD:C50([HeberGement:5])
	APPLY TO SELECTION:C70([HeberGement:5]; wUut_MajResApp)
	MESSAGES OFF:C175
	READ ONLY:C145([HeberGement:5])
End if 