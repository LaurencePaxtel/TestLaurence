// Method [DiaLogues].DL_CorrectionAppl.LB  
// 
// 
If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(tt_ItemOld)>0)
		If (tt_ItemOld>0)
			va_ItemValeur:=tt_ItemOld{tt_ItemOld}
		End if 
	End if 
End if 
