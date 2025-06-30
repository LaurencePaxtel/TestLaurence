
If (vb_ws_LancerFirst)
	P_CalcWebSite
	REDRAW:C174(va_ws_Message)
Else 
	ALERT:C41("Le processus est lancé !")
End if 
