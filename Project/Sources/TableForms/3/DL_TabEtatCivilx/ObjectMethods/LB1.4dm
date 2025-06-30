
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(->te_FuseEtCivCheck))
				
				If (Size of array:C274(te_FuseEtCivCheck)>0)
					If (te_FuseEtCivCheck>0)
						If (te_FuseEtCivCheck{te_FuseEtCivCheck}=1)
							te_FuseEtCivCheck{te_FuseEtCivCheck}:=0
						Else 
							te_FuseEtCivCheck{te_FuseEtCivCheck}:=1
						End if 
					End if 
				End if 
				
			: ($P_Col_current=(->ta_FuseEtCiv))
				
				If (Size of array:C274(ta_FuseEtCiv)>0)
					If (ta_FuseEtCiv>0)
						If (te_FuseEtCivCheck{ta_FuseEtCiv}=1)
							te_FuseEtCivCheck{ta_FuseEtCiv}:=0
						Else 
							te_FuseEtCivCheck{ta_FuseEtCiv}:=1
						End if 
					End if 
				End if 
			Else 
				//
		End case 
		
End case 

