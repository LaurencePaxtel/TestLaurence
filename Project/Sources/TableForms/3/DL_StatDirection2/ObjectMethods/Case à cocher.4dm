ARRAY BOOLEAN:C223(tb_Sel1; Size of array:C274(<>tl_PoA_DrOjT))
ARRAY BOOLEAN:C223(tb_Sel2; Size of array:C274(<>tl_PoA_DrOjT))
ARRAY BOOLEAN:C223(tb_Sel3; Size of array:C274(<>tl_PoA_OrNb))
ARRAY BOOLEAN:C223(tb_Sel4; Size of array:C274(<>tl_PoA_OrNb))

If (Bool:C1537(Form:C1466.maskedEmptyRow)=True:C214)
	outilsArrayVisibility(->tb_Sel1; -><>tl_PoA_DrOjT; ->tb_Sel2; -><>tl_PoA_DrOjT; ->tb_Sel3; -><>tl_PoA_OrNb; ->tb_Sel4; -><>tl_PoA_OrNb)
Else 
	outilsArrayVisibility(->tb_Sel1; False:C215; ->tb_Sel2; False:C215; ->tb_Sel3; False:C215; ->tb_Sel4; False:C215)
End if 