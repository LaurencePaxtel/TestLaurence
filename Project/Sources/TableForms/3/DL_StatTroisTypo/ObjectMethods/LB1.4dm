
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=->tl_MoisColNuit1)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 1; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit2)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 2; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit3)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 3; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit4)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 4; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit5)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 5; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit6)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 6; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit7)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 7; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit8)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 8; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit9)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 9; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit10)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 10; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit11)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 11; $P_Col_current->)
					End if 
				End if 
			: ($P_Col_current=->tl_MoisColNuit12)
				If (Size of array:C274($P_Col_current->)>0)
					If ($P_Col_current->>0)
						P_TroisTypoSelNouveaux("Nuit"; 12; $P_Col_current->)
					End if 
				End if 
				
			Else 
				//
		End case 
		
		
	: ($vl_EventFF=Sur double clic:K2:5)
		
		
		
End case 
