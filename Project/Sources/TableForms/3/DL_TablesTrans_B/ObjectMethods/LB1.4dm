
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(->tt_TransDocu))
				
				P_BAL_B(3)
				
			: ($P_Col_current=(->te_TransDocuCas))
				
				P_BAL_B(4)
		End case 
		
End case 
