If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_ColSiao_ColB)>0)
		If (ta_ColSiao_ColB>0)
			
			va_ColLogement:=ta_ColSiao_ColB{ta_ColSiao_ColB}
			
			REDRAW:C174([SIAO:50])
		End if 
	End if 
End if 