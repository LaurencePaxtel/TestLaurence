// Method [DiaLogues].DL_StatMaraude.LB  


C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=->te_Sel1)
				
				If (te_Sel1>0)
					If (te_Sel1{te_Sel1}=0)
						te_Sel1{te_Sel1}:=1
					Else 
						te_Sel1{te_Sel1}:=0
					End if 
				End if 
				
				
			Else 
				//
		End case 
		
		
		
		
End case 
