//Script b_VoirSel
If (Size of array:C274(te_Centre)>0)
	If (te_Centre{1}=1)
		$TailleTab:=0
		For ($ii; 1; Size of array:C274(te_Centre))
			te_Centre{$ii}:=0
		End for 
	Else 
		$TailleTab:=Size of array:C274(te_Centre)
		For ($ii; 1; Size of array:C274(te_Centre))
			te_Centre{$ii}:=1
		End for 
	End if 
	va_TailCtr:=String:C10($TailleTab)+" \\ "+String:C10(Size of array:C274(te_Centre))
Else 
	va_TailCtr:=""
End if 