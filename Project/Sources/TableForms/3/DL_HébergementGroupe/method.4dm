If (Form event code:C388=Sur appel extérieur:K2:11)
	Case of 
		: (<>va_GroupeAction="Quit")
			CANCEL:C270
		: (<>va_GroupeAction="Redessiner")
			REDRAW WINDOW:C456
			
			
	End case 
End if 