//%attributes = {}
If (Accès_Groupe(<>Groupe_DemPrestations))
	
	C_BOOLEAN:C305($vb_OK)
	$vb_OK:=F_CompteurGIP(<>Va_DemP; <>ta_DemP; -><>ta_DemP; -><>ta_DemPCd)
	Process_Go(-><>PR_GIP; "Go_GIP_2"; "CentresGIP"; 128)
	//  GIP_PopUp (◊Va_DemP;◊ta_DemP;->◊ta_DemP;->◊ta_DemPCd)
End if 