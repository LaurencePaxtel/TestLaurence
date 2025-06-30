//Script b_115
CONFIRM:C162("Confirmez vous la suppression des rubriques ecran ?")
If (OK=1)
	MESSAGES ON:C181
	ALL RECORDS:C47([LesRubriques:21])
	MultiSoc_Filter(->[LesRubriques:21])
	If (Records in selection:C76([LesRubriques:21])>0)
		READ WRITE:C146([LesRubriques:21])
		DELETE SELECTION:C66([LesRubriques:21])
		UNLOAD RECORD:C212([LesRubriques:21])
		READ ONLY:C145([LesRubriques:21])
	End if 
End if 