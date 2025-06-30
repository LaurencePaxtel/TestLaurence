If (Form event code:C388=Sur appel extérieur:K2:11)
	Case of 
		: (<>va_RéserveAction="Quit")
			CANCEL:C270
		: (<>va_RéserveAction="Redessiner")
			REDRAW WINDOW:C456
			SORT ARRAY:C229(<>ta_FamilleClé; <>tl_FamilleID; <>ta_FamilleEtCv; >)
			
	End case 
End if 