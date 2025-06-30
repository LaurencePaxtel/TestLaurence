If (Form event code:C388=Sur clic:K2:4)
	If (Modified record:C314([HeBerge:4]))
		Quit_HBNotesActT
	Else 
		CANCEL:C270
	End if 
End if 