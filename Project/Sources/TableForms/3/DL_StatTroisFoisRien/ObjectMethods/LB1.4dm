
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=(->ta_3FR_AutreSol))
				
				If (Size of array:C274(ta_3FR_AutreSol)>0)
					If (ta_3FR_AutreSol>0)
						P_TroisFoisRien(10; 0; 0; !00-00-00!)
					End if 
				End if 
				
				
			Else 
				//
		End case 
		
		
End case 
