If (Form event code:C388=Sur données modifiées:K2:15)
	C_OBJECT:C1216($info_o)
	
	outilsWProChargerDocument("recherche"; False:C215; ->$info_o; Form:C1466.nomDocument)
	Form:C1466.DOCWPRO:=$info_o.DOCWPRO
End if 