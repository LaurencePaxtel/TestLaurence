
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(->te_xEtCiv))
				
				If (Size of array:C274(te_xEtCiv)>0)
					If (te_xEtCiv>0)
						If (te_xEtCiv{te_xEtCiv}=1)
							te_xEtCiv{te_xEtCiv}:=0
						Else 
							te_xEtCiv{te_xEtCiv}:=1
						End if 
					End if 
				End if 
				
			: ($P_Col_current=(->ta_xEtCiv))
				
				If (Size of array:C274(te_xEtCiv)>0)
					If (ta_xEtCiv>0)
						If (te_xEtCiv{ta_xEtCiv}=1)
							te_xEtCiv{ta_xEtCiv}:=0
						Else 
							te_xEtCiv{ta_xEtCiv}:=1
						End if 
					End if 
				End if 
			Else 
				//
		End case 
		
End case 

