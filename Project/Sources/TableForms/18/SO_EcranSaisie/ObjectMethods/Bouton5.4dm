If (Form event code:C388=Sur clic:K2:4)
	If (F_CentreNoModifier)
		BEEP:C151
		[SOciete:18]SO_CodeCentre:23:=ve_T_CentreCodeNew
		<>vl_T_CentreCodeDebut:=vl_T_CentreCodeNewDebut
		<>vl_T_CentreCodeFin:=vl_T_CentreCodeNewFin
		SAVE RECORD:C53([SOciete:18])
		
	End if 
End if 