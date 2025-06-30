Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_OBJECT:C1216($info_o)
		
		outilsWProChargerDocument("enCours"; False:C215; ->$info_o)
		
		Form:C1466.DOCWPRO:=$info_o.DOCWPRO
		Form:C1466.nomDocument:=""
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 