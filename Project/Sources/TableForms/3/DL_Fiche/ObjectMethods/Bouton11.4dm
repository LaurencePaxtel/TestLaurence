
If (Size of array:C274(<>ta_ConsoB_Document)>0)
	<>ta_ConsoB_Document:=1
	<>ta_ConsoB_Document{0}:=<>ta_ConsoB_Document{<>ta_ConsoB_Document}
	P_VarParamConsoVoir(2)
	If (<>ta_ConsoB_Document>0)
		P_ConsoVoir(<>ta_ConsoB_Document)
	End if 
End if 