var $position_t : Text

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$position_t:="center"
		outilsCreateWindowsForm("situationsSoldeDueUsager"; ->$position_t; New object:C1471("appel"; Num:C11(Form:C1466.appel)); ->[Factures:86])
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 