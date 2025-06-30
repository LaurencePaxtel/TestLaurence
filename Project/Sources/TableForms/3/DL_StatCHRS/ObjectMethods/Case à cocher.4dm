ARRAY BOOLEAN:C223(tb_Sel1; Size of array:C274(tl_ET_Dem))
ARRAY BOOLEAN:C223(tb_Sel2; Size of array:C274(tl_LC_Dis))
ARRAY BOOLEAN:C223(tb_Sel3; Size of array:C274(tl_LC_PrestaNb))
ARRAY BOOLEAN:C223(tb_Sel4; Size of array:C274(tl_xNbSgltJ))
ARRAY BOOLEAN:C223(tb_Sel5; Size of array:C274(tl_xNbIdtéJ))

If (Bool:C1537(Form:C1466.maskedEmptyRow)=True:C214)
	outilsArrayVisibility(->tb_Sel1; ->tl_ET_Dem; ->tb_Sel2; ->tl_LC_Dis; ->tb_Sel3; ->tl_LC_PrestaNb; ->tb_Sel4; ->tl_xNbSgltJ; ->tb_Sel5; ->tl_xNbIdtéJ)
Else 
	outilsArrayVisibility(->tb_Sel1; False:C215; ->tb_Sel2; False:C215; ->tb_Sel3; False:C215; ->tb_Sel4; False:C215; ->tb_Sel5; False:C215)
End if 