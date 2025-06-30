
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=(->tl_FluxFirst))
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatFlux(Self:C308; "Au premier jour"; "tl_FluxFirst_")
					End if 
				End if 
				
			: ($P_Col_current=(->tl_FluxFirstP))
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatFlux(->tl_FluxFirst; "Au premier jour"; "tl_FluxFirst_")
					End if 
				End if 
				
			: ($P_Col_current=(->tl_FluxIn))
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatFlux(Self:C308; "Les entrées"; "tl_FluxIn_")
					End if 
				End if 
				
			: ($P_Col_current=(->tl_FluxInP))
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatFlux(->tl_FluxIn; "Les entrées"; "tl_FluxIn_")
					End if 
				End if 
				
			: ($P_Col_current=(->tl_FluxOut))
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatFlux(Self:C308; "Les sorties"; "tl_FluxOut_")
					End if 
				End if 
				
			: ($P_Col_current=(->tl_FluxOutP))
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatFlux(->tl_FluxOut; "Les sorties"; "tl_FluxOut_")
					End if 
				End if 
				
			: ($P_Col_current=(->tl_FluxOutN))
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatFlux(->tl_FluxOut; "Les sorties"; "tl_FluxOut_")
					End if 
				End if 
				
			: ($P_Col_current=(->tl_FluxLast))
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatFlux(Self:C308; "Au dernier jour"; "tl_FluxLast_")
					End if 
				End if 
				
			: ($P_Col_current=(->tl_FluxLastP))
				
				If (Size of array:C274(Self:C308->)>0)
					If (Self:C308->>0)
						P_StatFlux(->tl_FluxLast; "Au dernier jour"; "tl_FluxLast_")
					End if 
				End if 
			Else 
				//
		End case 
		
		
End case 

//tl_FluxFirst
//tl_FluxFirstP
//tl_FluxIn
//tl_FluxInP
//tl_FluxOut
//tl_FluxOutP
//tl_FluxOutN
//tl_FluxLast
//tl_FluxLastP
























