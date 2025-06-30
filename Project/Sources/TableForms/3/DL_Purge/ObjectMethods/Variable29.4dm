//Script b_SexeEtc
CONFIRM:C162("Confirmez vous le mise à jour du genre"+" en fonction de l'état civil !")
If (OK=1)
	MESSAGES ON:C181
	READ WRITE:C146([HeBerge:4])
	READ WRITE:C146([HeberGement:5])
	ALL RECORDS:C47([HeberGement:5])
	MultiSoc_Filter(->[HeberGement:5])
	If (Records in selection:C76([HeberGement:5])>0)
		FIRST RECORD:C50([HeberGement:5])
		APPLY TO SELECTION:C70([HeberGement:5]; wUut_MàJGenreE)
	End if 
	READ ONLY:C145([HeBerge:4])
	READ ONLY:C145([HeberGement:5])
	BEEP:C151
End if 