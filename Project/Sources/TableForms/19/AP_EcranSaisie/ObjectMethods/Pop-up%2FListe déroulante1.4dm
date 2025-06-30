If (Size of array:C274(<>ta_Appels)>0)
	
	If (<>ta_Appels>0)
		[APpels:19]AP_Libellé:5:=<>ta_Appels{<>ta_Appels}
	Else 
		<>ta_Appels:=Find in array:C230(<>ta_Appels; [APpels:19]AP_Libellé:5)
	End if 
	
End if 