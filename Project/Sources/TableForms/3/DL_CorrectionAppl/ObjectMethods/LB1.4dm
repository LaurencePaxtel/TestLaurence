// Method [DiaLogues].DL_CorrectionAppl.LB1  
// 
If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_ItemEum)>0)
		If (ta_ItemEum>0)
			va_ItemValeur:=ta_ItemEum{ta_ItemEum}
		Else 
			va_ItemValeur:=""
		End if 
	End if 
End if 