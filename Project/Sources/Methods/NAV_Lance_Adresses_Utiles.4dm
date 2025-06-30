//%attributes = {}

C_BOOLEAN:C305($vb_OK)
If (Accès_Groupe(<>Groupe_DemAdrUtil))
	$vb_OK:=F_CompteurGIP(<>Va_AdUtil; <>ta_AdUtil; -><>ta_AdUtil; -><>ta_AdUtilCd)
	Process_Go(-><>PR_GIP; "Go_GIP_2"; "CentresGIP"; 128)
	//  GIP_PopUp (◊Va_AdUtil;◊ta_AdUtil;->◊ta_AdUtil;->◊ta_AdUtilCd)
End if 

