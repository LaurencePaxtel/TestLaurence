If (<>PR_ConsoClientA=0)
	CANCEL:C270
Else 
	ALERT:C41("La consolidation sur le client est active et en cours !"+<>va_CR+"Modifier les paramètres !")
End if 

