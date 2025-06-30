If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(te_TriSel)>0)
		If (te_TriSel{1}>0)
			For ($ii; 1; Size of array:C274(te_TriSel))
				te_TriSel{$ii}:=0
			End for 
		Else 
			For ($ii; 1; Size of array:C274(te_TriSel))
				te_TriSel{$ii}:=$ii
			End for 
		End if 
	End if 
End if 