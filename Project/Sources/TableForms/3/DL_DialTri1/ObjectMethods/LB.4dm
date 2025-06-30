// Method [DiaLogues].DL_DialTri1.LB  
// 
C_LONGINT:C283($vl_eventFF)
$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		
		If (Size of array:C274(ta_xTri)>0)
			ta_xTri:=Find in array:C230(ta_xTri; ta_xTri{0})
			If (ta_xTri>0)
			Else 
				ta_xTri:=0
				ta_xTri{0}:=""
			End if 
		End if 
		
	: ($vl_eventFF=Sur double clic:K2:5)
		
		If (Size of array:C274(ta_xTri)>0)
			If (ta_xTri>0)
				ta_xTri{0}:=ta_xTri{ta_xTri}
			Else 
				ta_xTri{0}:=""
			End if 
		End if 
End case 
