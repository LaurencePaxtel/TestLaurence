C_LONGINT:C283($ii)

If (Size of array:C274(ta_xCentre)>0)
	If (va_xCentreCritere>"")
		For ($ii; 1; Size of array:C274(ta_xCentre))
			If (ta_xCentre{$ii}=(va_xCentreCritere+"@"))
				te_xCentre{$ii}:=1
			End if 
		End for 
	End if 
End if 