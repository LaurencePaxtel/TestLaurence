If (Form event code:C388=Sur clic:K2:4)
	If (Modified record:C314([HeBerge:4])) | (vt_TempNOTEMAR>"") | (vt_TempNOTEMAR2>"")
		Quit_HBNotesMRF
	Else 
		CANCEL:C270
	End if 
End if 
