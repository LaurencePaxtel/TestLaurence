
If (Size of array:C274(ta_LesIndices)>0)
	If (ta_LesIndices<0)
		ta_LesIndices:=1
	Else 
		If ((ta_LesIndices+1)<=Size of array:C274(ta_LesIndices))
			ta_LesIndices:=ta_LesIndices+1
		Else 
			ta_LesIndices:=Size of array:C274(ta_LesIndices)
		End if 
	End if 
	ta_LesIndices{0}:=ta_LesIndices{ta_LesIndices}
End if 