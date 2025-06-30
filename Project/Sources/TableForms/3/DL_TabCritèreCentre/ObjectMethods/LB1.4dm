
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(-><>te_VeilCentre))
				
				If (Size of array:C274(<>te_VeilCentre)>0)
					If (<>te_VeilCentre>0)
						If (<>te_VeilCentre{<>te_VeilCentre}=1)
							<>te_VeilCentre{<>te_VeilCentre}:=0
						Else 
							<>te_VeilCentre{<>te_VeilCentre}:=1
						End if 
					End if 
				End if 
				
			: ($P_Col_current=(-><>ta_VeilCentre))
				
				If (Size of array:C274(<>ta_VeilCentre)>0)
					If (<>ta_VeilCentre>0)
						If (Macintosh control down:C544 | Windows Ctrl down:C562 | Macintosh option down:C545 | Windows Alt down:C563)
							<>va_VeilCentrePrefixe:=<>ta_VeilCentre{<>ta_VeilCentre}
						Else 
							
							If (<>te_VeilCentre{<>ta_VeilCentre}=1)
								<>te_VeilCentre{<>ta_VeilCentre}:=0
							Else 
								<>te_VeilCentre{<>ta_VeilCentre}:=1
							End if 
						End if 
					End if 
				End if 
			Else 
				//
		End case 
		
End case 
