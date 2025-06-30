If (Form event code:C388=Sur clic:K2:4)
	C_LONGINT:C283($ii; $NoTable)
	
	$NoTable:=Table:C252(->[TrancheAge:40])
	
	ARRAY TEXT:C222(<>ta_TrancheAge; [TrancheAge:40]TA_Tranche_0Nombre:1)
	ARRAY INTEGER:C220(<>te_TrancheAge; [TrancheAge:40]TA_Tranche_0Nombre:1)
	
	For ($ii; 1; Size of array:C274(<>ta_TrancheAge))
		<>ta_TrancheAge{$ii}:=Field:C253($NoTable; $ii+1)->
		<>te_TrancheAge{$ii}:=Field:C253($NoTable; $ii+10)->
	End for 
	
	SAVE RECORD:C53([TrancheAge:40])
End if 