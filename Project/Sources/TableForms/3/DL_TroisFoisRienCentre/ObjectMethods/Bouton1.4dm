
If (Size of array:C274(ta_LesCentre)>0)
	If (ta_LesCentre<0)
		ta_LesCentre:=1
	Else 
		If ((ta_LesCentre-1)>0)
			ta_LesCentre:=ta_LesCentre-1
		Else 
			ta_LesCentre:=1
		End if 
	End if 
	ta_LesCentre{0}:=ta_LesCentre{ta_LesCentre}
End if 