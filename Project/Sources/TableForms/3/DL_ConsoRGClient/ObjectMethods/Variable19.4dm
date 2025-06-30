If (<>PR_ConsoRGClientA=0)
	CANCEL:C270
Else 
	ALERT:C41("La consolidation régionale sur le client est active et en cours !"+<>va_CR+"Modifier les paramètres !")
End if 

