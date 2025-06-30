If (Form event code:C388=Sur clic:K2:4)
	
	<>vb_ParamDisActivée:=(w1=1)
	<>vb_ParamDisJour:=(rJourNuit1=1)
	<>vb_ParamDisNuit:=(rJourNuit2=1)
	<>vb_ParamDisBt:=(s1=1)
	DébutBtMenu(4; "")
	
	DébutInitPrDispo(1)
	
End if 
DébutInitPrDispo(0)