$vl_EventFF:=Form event code:C388
Case of 
		
	: ($vl_EventFF=Sur chargement:K2:1)
		//q1:=Num(<>va_CentreEXC="O")
		//q2:=Num(<>va_CentreEXC="N")
		
		
		//r1:=Num(<>va_CentreEXCExc="O")
		//r2:=Num(<>va_CentreEXCExc="N")
		
		
		//s1:=Num(<>va_CentreEXCSor="O")
		//s2:=Num(<>va_CentreEXCSor="N")
		
		
	: ($vl_EventFF=Sur double clic:K2:5)
		If (Size of array:C274(te_CCE_Check)>0)
			If (te_CCE_Check>0)
				If (te_CCE_Check{te_CCE_Check}=1)
					te_CCE_Check{te_CCE_Check}:=0
					
					va_CCE_Nom:=String:C10(vl_TT)+" dont : "+String:C10(vl_NT-1)+" sélectionné(s)"
					
				Else 
					te_CCE_Check{te_CCE_Check}:=1
					va_CCE_Nom:=String:C10(vl_TT)+" dont : "+String:C10(vl_NT+1)+" sélectionné(s)"
					
				End if 
			End if 
		End if 
End case 
