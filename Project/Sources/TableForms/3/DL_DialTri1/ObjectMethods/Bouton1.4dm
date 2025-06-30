If (Size of array:C274(ta_xTri)>0)
	If (ta_xTri<0)
		ta_xTri:=1
	Else 
		If ((ta_xTri-1)>0)
			ta_xTri:=ta_xTri-1
		Else 
			ta_xTri:=1
		End if 
	End if 
	ta_xTri{0}:=ta_xTri{ta_xTri}
End if 