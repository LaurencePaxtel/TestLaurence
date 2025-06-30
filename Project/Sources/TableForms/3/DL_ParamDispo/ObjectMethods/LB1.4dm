
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=Self:C308
Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(->te_LesIndices))
				
				If (Size of array:C274(te_LesIndices)>0)
					If (te_LesIndices>0)
						If (te_LesIndices{te_LesIndices}=1)
							te_LesIndices{te_LesIndices}:=0
						Else 
							te_LesIndices{te_LesIndices}:=1
						End if 
					End if 
				End if 
				
			: ($P_Col_current=(->ta_LesIndices))
				
				If (Size of array:C274(ta_LesIndices)>0)
					If (ta_LesIndices>0)
						If (te_LesIndices{ta_LesIndices}=1)
							te_LesIndices{ta_LesIndices}:=0
						Else 
							te_LesIndices{ta_LesIndices}:=1
						End if 
					End if 
				End if 
			Else 
				
		End case 
		
End case 




