If (Form event code:C388=Sur données modifiées:K2:15)
	SET TIMER:C645(((((vh_ws_Période\3600)*3600)+(((vh_ws_Période\60)%60)*60)+(vh_ws_Période%60))*60))
	
End if 