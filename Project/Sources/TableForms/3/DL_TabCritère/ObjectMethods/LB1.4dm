
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(-><>te_xCheck))
				
				If (Size of array:C274(<>te_xCheck)>0)
					If (<>te_xCheck>0)
						If (<>te_xCheck{<>te_xCheck}=1)
							<>te_xCheck{<>te_xCheck}:=0
						Else 
							<>te_xCheck{<>te_xCheck}:=1
						End if 
					End if 
				End if 
				
			: ($P_Col_current=(-><>ta_xLibellé))
				
				If (Size of array:C274(<>ta_xLibellé)>0)
					If (<>ta_xLibellé>0)
						If (<>te_xCheck{<>ta_xLibellé}=1)
							<>te_xCheck{<>ta_xLibellé}:=0
						Else 
							<>te_xCheck{<>ta_xLibellé}:=1
						End if 
					End if 
				End if 
			Else 
				//
		End case 
		
End case 
