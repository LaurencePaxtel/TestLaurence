If (Form event code:C388=Sur clic:K2:4)
	If (Modified record:C314([HeBerge:4])) | (vt_TempActi>"")
		Quit_HBAction
	Else 
		CANCEL:C270
	End if 
End if 