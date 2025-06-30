
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=->tl_TrancheCol1)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 1; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol2)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 2; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol3)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 3; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol4)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 4; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol5)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 5; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol6)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 6; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol7)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 7; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol8)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 8; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol9)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 9; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol10)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 10; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol11)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 11; Self:C308->)
					End if 
				End if 
				
			: ($P_Col_current=->tl_TrancheCol12)
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatTranche("TR"; 12; Self:C308->)
					End if 
				End if 
			Else 
				//
		End case 
		
		
		
End case 


