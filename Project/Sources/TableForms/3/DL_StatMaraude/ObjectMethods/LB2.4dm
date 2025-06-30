// Method [DiaLogues].DL_StatMaraude.LB2  


C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=->te_Sel3)
				
				If (te_Sel3>0)
					If (te_Sel3{te_Sel3}=0)
						te_Sel3{te_Sel3}:=1
					Else 
						te_Sel3{te_Sel3}:=0
					End if 
				End if 
				
				
			Else 
				//
		End case 
		
		
		
		
End case 


