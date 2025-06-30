If (Form event code:C388=Sur clic:K2:4)
	
	// #20170713-2
	If (Modified record:C314([HeBerge:4]))\
		 | (vt_TempNOTE>"")\
		 | (vt_TempNOTE2>"")\
		 | (vt_TempNOTE3>"")\
		 | (vt_TempNOTETRANS>"")\
		 | (vt_TempNOTEMARAUDE#"")\
		 | (vt_TempNOTEMARAUDE2#"")\
		 | (vt_TempNOTEFFV#"")\
		 | (vt_TempNOTEComptable#"")
		
		Quit_HBNotesF
	Else 
		CANCEL:C270
	End if 
	
End if 
