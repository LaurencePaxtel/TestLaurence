
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=(->te_yCtreP_Ordre))
				
				If (Size of array:C274(te_yCtreP_Ordre)>0)
					Tab_ItemGrouper_CtrP(4; te_yCtreP_Ordre; 2)
				End if 
				
			: ($P_Col_current=(->te_yCtreP_Check))
				
				If (Size of array:C274(te_yCtreP_Check)>0)
					Tab_ItemGrouper_CtrP(4; te_yCtreP_Check; 2)
				End if 
				
			: ($P_Col_current=(->ta_yCtreP))
				
				If (Size of array:C274(ta_yCtreP)>0)
					Tab_ItemGrouper_CtrP(4; ta_yCtreP; 2)
				End if 
				
			: ($P_Col_current=(->te_yCtreP_Etat))
				
				If (Size of array:C274(te_yCtreP_Etat)>0)
					Tab_ItemGrouper_CtrP(4; te_yCtreP_Etat; 2)
				End if 
			Else 
				//
		End case 
		
End case 


