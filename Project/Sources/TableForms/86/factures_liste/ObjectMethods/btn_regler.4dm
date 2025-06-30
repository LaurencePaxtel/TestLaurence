// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 24/01/20, 17:12:42
// ----------------------------------------------------
// Method: [Factures].edit.btn_regler
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $position_t : Text
var $pos_el : Integer

var reg_is_new_record : Boolean

// Modifié par : Scanu Rémy (23/02/2022)
$position_t:="center"

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$pos_el:=Find in array:C230(tb_fac_choix; True:C214)
		reg_is_new_record:=True:C214
		
		If ($pos_el>0)
			outilsCreateWindowsForm("edit_reglement"; ->$position_t; New object:C1471("titreFenetre"; "Edition d'un règlement"; "appel"; 1); ->[Factures:86])
			FAC_Get_Liste_Factures
		Else 
			ALERT:C41("Veuillez sélectionner une ou plusieurs facture à régler")
		End if 
		
End case 