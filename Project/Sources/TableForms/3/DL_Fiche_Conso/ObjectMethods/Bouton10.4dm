
If (Size of array:C274(<>ta_ConsoB_Document)>0)
	If (<>ta_ConsoB_Document<0)
		<>ta_ConsoB_Document:=1
	Else 
		If ((<>ta_ConsoB_Document-1)>0)
			<>ta_ConsoB_Document:=<>ta_ConsoB_Document-1
		Else 
			<>ta_ConsoB_Document:=1
		End if 
	End if 
	<>ta_ConsoB_Document{0}:=<>ta_ConsoB_Document{<>ta_ConsoB_Document}
	P_VarParamConsoVoir(2)
	
	If (<>ta_ConsoB_Document>0)
		P_ConsoVoir(<>ta_ConsoB_Document)
	End if 
End if 