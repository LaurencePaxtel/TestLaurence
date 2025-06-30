
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(-><>te_xCheck80))
				
				If (Size of array:C274(<>te_xCheck80)>0)
					If (<>te_xCheck80>0)
						If (<>te_xCheck80{<>te_xCheck80}=1)
							<>te_xCheck80{<>te_xCheck80}:=0
						Else 
							<>te_xCheck80{<>te_xCheck80}:=1
						End if 
					End if 
				End if 
				
			: ($P_Col_current=(-><>ta_xLibellé80))
				
				
				If (Size of array:C274(<>ta_xLibellé80)>0)
					If (<>ta_xLibellé80>0)
						If (<>te_xCheck80{<>ta_xLibellé80}=1)
							<>te_xCheck80{<>ta_xLibellé80}:=0
						Else 
							<>te_xCheck80{<>ta_xLibellé80}:=1
						End if 
					End if 
				End if 
				
			Else 
				//
		End case 
		
End case 
