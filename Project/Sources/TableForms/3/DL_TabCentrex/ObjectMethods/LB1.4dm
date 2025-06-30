
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(->te_xCentre))
				
				If (Size of array:C274(te_xCentre)>0)
					If (te_xCentre>0)
						If (te_xCentre{te_xCentre}=1)
							te_xCentre{te_xCentre}:=0
						Else 
							te_xCentre{te_xCentre}:=1
						End if 
					End if 
				End if 
				
			: ($P_Col_current=(->ta_xCentre))
				
				If (Size of array:C274(ta_xCentre)>0)
					If (ta_xCentre>0)
						If (Macintosh control down:C544 | Windows Ctrl down:C562 | Macintosh option down:C545 | Windows Alt down:C563)
							va_xCentreCritere:=ta_xCentre{ta_xCentre}
						Else 
							If (te_xCentre{ta_xCentre}=1)
								te_xCentre{ta_xCentre}:=0
							Else 
								te_xCentre{ta_xCentre}:=1
							End if 
							
						End if 
					End if 
				End if 
			Else 
				//
		End case 
		
End case 
