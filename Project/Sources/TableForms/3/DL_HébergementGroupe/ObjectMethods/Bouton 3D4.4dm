If (Size of array:C274(<>ta_GpClé)>0)
	<>vt_Trans:=""
	For ($ii; 1; Size of array:C274(<>ta_GpClé))
		<>vt_Trans:=<>vt_Trans+<>va_Cr+<>ta_GpClé{$ii}+"     : "+<>ta_GpEtCv{$ii}
	End for 
	If (<>PR_AppelMem#0)
		POST OUTSIDE CALL:C329(<>PR_AppelMem)
	Else 
		QUERY:C277([MemO:30]; [MemO:30]MO_UserID:1=<>vl_UserRéfU)
		If (Records in selection:C76([MemO:30])=1)
			READ WRITE:C146([MemO:30])
			If (i_NonVerrou(->[MemO:30]))
				[MemO:30]MO_Note:5:=[MemO:30]MO_Note:5+<>va_CR+<>va_CR+<>vt_Trans+<>va_CR
				SAVE RECORD:C53([MemO:30])
				UNLOAD RECORD:C212([MemO:30])
			End if 
			READ ONLY:C145([MemO:30])
		Else 
			StrAlerte(4; "")
		End if 
		UNLOAD RECORD:C212([MemO:30])
		//StrAlerte (17;"")
	End if 
End if 