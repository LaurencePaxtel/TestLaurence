
If (Size of array:C274(tt_EnumEx_Nom)>0)
	If (tt_EnumEx_Nom<0)
		tt_EnumEx_Nom:=1
	Else 
		If ((tt_EnumEx_Nom+1)<=Size of array:C274(tt_EnumEx_Nom))
			tt_EnumEx_Nom:=tt_EnumEx_Nom+1
		Else 
			tt_EnumEx_Nom:=Size of array:C274(tt_EnumEx_Nom)
		End if 
	End if 
	tt_EnumEx_Nom{0}:=tt_EnumEx_Nom{tt_EnumEx_Nom}
End if 
