C_LONGINT:C283($ii)

If (Size of array:C274(ta_VeilCentre)>0)
	If (va_VeilCentrePrefixe>"")
		For ($ii; 1; Size of array:C274(ta_VeilCentre))
			If (ta_VeilCentre{$ii}=(va_VeilCentrePrefixe+"@"))
				te_VeilCentre{$ii}:=1
			End if 
		End for 
	End if 
End if 