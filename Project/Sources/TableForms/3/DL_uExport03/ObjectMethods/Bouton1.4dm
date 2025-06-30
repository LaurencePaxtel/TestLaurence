If (vb_OKTêtes=True:C214)
	SET WINDOW TITLE:C213("Export des noms des champs")
	va_TAB:=Char:C90(13)
	vb_OKTêtes:=False:C215
Else 
	SET WINDOW TITLE:C213("Export")
	va_TAB:=Char:C90(9)
	vb_OKTêtes:=True:C214
End if 