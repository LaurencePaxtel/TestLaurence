
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=(->te_yCtreH_Ordre))
				
				If (Size of array:C274(te_yCtreH_Ordre)>0)
					Tab_ItemGrouper_CtrH(4; te_yCtreH_Ordre; 2)
				End if 
				
			: ($P_Col_current=(->te_yCtreH_Check))
				
				If (Size of array:C274(te_yCtreH_Check)>0)
					Tab_ItemGrouper_CtrH(4; te_yCtreH_Check; 2)
				End if 
				
			: ($P_Col_current=(->ta_yCtreH))
				
				If (Size of array:C274(ta_yCtreH)>0)
					Tab_ItemGrouper_CtrH(4; ta_yCtreH; 2)
				End if 
				
			: ($P_Col_current=(->te_yCtreH_Etat))
				
				If (Size of array:C274(te_yCtreH_Etat)>0)
					Tab_ItemGrouper_CtrH(4; te_yCtreH_Etat; 2)
				End if 
			Else 
				//
		End case 
		
End case 



