// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 19/01/20, 18:37:34
// ----------------------------------------------------
// Method: [Factures].edit.btn_export_compta
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($pos)
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$pos:=Find in array:C230(tb_fac_choix; True:C214)
		
		If ($pos>0)
			FAC_Export_Compta
		Else 
			ALERT:C41("Veuillez sélectionner une ou plusieurs facture à exporter")
		End if 
		
End case 