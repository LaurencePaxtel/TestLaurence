
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=(->ta_xCtreP))
				
				If (Size of array:C274(ta_xCtreP)>0)
					Tab_ItemGrouper_CtrP(4; ta_xCtreP; 1)
				End if 
				
			: ($P_Col_current=(->te_xCtreP_Fermé))
				
				If (Size of array:C274(te_xCtreP_Fermé)>0)
					Tab_ItemGrouper_CtrP(4; te_xCtreP_Fermé; 1)
				End if 
				
			: ($P_Col_current=(->te_xCtreP))
				
				If (Size of array:C274(te_xCtreP)>0)
					Tab_ItemGrouper_CtrP(4; te_xCtreP; 1)
				End if 
				
			: ($P_Col_current=(->te_xCtreP_Etat))
				
				If (Size of array:C274(te_xCtreP_Etat)>0)
					Tab_ItemGrouper_CtrP(4; te_xCtreP_Etat; 1)
				End if 
			Else 
				//
		End case 
End case 








