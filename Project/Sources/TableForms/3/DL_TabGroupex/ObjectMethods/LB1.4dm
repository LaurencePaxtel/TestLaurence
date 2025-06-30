C_LONGINT:C283($vl_EventFF)
C_POINTER:C301($P_Col_current)

$vl_EventFF:=Form event code:C388
$P_Col_current:=OBJECT Get pointer:C1124

Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(->te_xGroupe))
				
				If (Size of array:C274(te_xGroupe)>0)
					
					If (te_xGroupe>0)
						
						If (te_xGroupe{te_xGroupe}=1)
							te_xGroupe{te_xGroupe}:=0
						Else 
							te_xGroupe{te_xGroupe}:=1
						End if 
						
					End if 
					
				End if 
				
			: ($P_Col_current=(->ta_xGroupe))
				
				If (Size of array:C274(ta_xGroupe)>0)
					
					If (ta_xGroupe>0)
						
						If (te_xGroupe{ta_xGroupe}=1)
							te_xGroupe{ta_xGroupe}:=0
						Else 
							te_xGroupe{ta_xGroupe}:=1
						End if 
						
					End if 
					
				End if 
				
		End case 
		
End case 