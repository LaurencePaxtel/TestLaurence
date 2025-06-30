// ----------------------------------------------------
// User name (OS): Kevin  HASSAL
// Date and time: 07/11/19, 13:50:22
// ----------------------------------------------------
// Method: [DiaLogues].DL_Multi_Pointage.btn_valider
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		txt_centre_nom:=""
		Form:C1466.validate:=True:C214
		
		POST OUTSIDE CALL:C329(Current process:C322)
End case 