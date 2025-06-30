ARRAY BOOLEAN:C223(tb_Sel1; Size of array:C274(tl_Nb1))
ARRAY BOOLEAN:C223(tb_Sel2; Size of array:C274(tl_Nb2))
ARRAY BOOLEAN:C223(tb_Sel3; Size of array:C274(tl_Nb3))
ARRAY BOOLEAN:C223(tb_Sel4; Size of array:C274(tl_Nb4))

If (Bool:C1537(Form:C1466.maskedEmptyRow)=True:C214)
	outilsArrayVisibility(->tb_Sel1; ->tl_Nb1; ->tb_Sel2; ->tl_Nb2; ->tb_Sel3; ->tl_Nb3; ->tb_Sel4; ->tl_Nb4)
Else 
	outilsArrayVisibility(->tb_Sel1; False:C215; ->tb_Sel2; False:C215; ->tb_Sel3; False:C215; ->tb_Sel4; False:C215)
End if 