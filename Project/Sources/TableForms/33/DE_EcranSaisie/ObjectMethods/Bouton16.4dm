
C_TEXT:C284(vt_memoNote)
C_TEXT:C284(va_DateEtHeure)


_O_PAGE SETUP:C299([DossierSante:33]; "DE_EcranMemo")
PRINT SETTINGS:C106
If (OK=1)
	vt_memoNote:=[DossierSante:33]DE_NoteObservation:71
	va_DateEtHeure:="le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)
	FORM SET OUTPUT:C54([DossierSante:33]; "DE_EcranMemo")
	FORM SET INPUT:C55([DossierSante:33]; "DE_EcranMemo")
	PRINT RECORD:C71([DossierSante:33]; *)
End if 