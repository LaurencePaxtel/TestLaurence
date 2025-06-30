//%attributes = {}

C_BOOLEAN:C305($vb_OK)

If (Accès_Groupe(<>Groupe_DemSitPart))
	$vb_OK:=F_CompteurGIP(<>Va_SitPar; <>ta_SitPar; -><>ta_SitPar; -><>ta_SitParCd)
	Process_Go(-><>PR_GIP; "Go_GIP_2"; "CentresGIP"; 128)
	// GIP_PopUp (◊Va_SitPar;◊ta_SitPar;->◊ta_SitPar;->◊ta_SitParCd)
End if 

