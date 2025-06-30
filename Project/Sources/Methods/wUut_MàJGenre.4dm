//%attributes = {}
READ WRITE:C146([HeBerge:4])
READ WRITE:C146([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_EtatCivil:20="Fem@")
MultiSoc_Filter(->[HeberGement:5])
If (Records in selection:C76([HeberGement:5])>0)
	MESSAGES ON:C181
	APPLY TO SELECTION:C70([HeberGement:5]; wUut_MajGenrePl)
	MESSAGES OFF:C175
End if 
READ ONLY:C145([HeBerge:4])
READ ONLY:C145([HeberGement:5])