ARRAY BOOLEAN:C223(tb_Sel1; Size of array:C274(t_CT_Total))
ARRAY BOOLEAN:C223(tb_Sel2; Size of array:C274(t_ET_Dem))
ARRAY BOOLEAN:C223(tb_Sel3; Size of array:C274(t_SG_Dem))
ARRAY BOOLEAN:C223(tb_Sel4; Size of array:C274(tl_xGroupe))
ARRAY BOOLEAN:C223(tb_Sel5; Size of array:C274(tl_xFMCaS))

ARRAY BOOLEAN:C223(tb_Sel6; Size of array:C274(tl_xFMDis3))
ARRAY BOOLEAN:C223(tb_Sel7; Size of array:C274(tl_xFMDis1))
ARRAY BOOLEAN:C223(tb_Sel8; Size of array:C274(tl_xFMDis4))
ARRAY BOOLEAN:C223(tb_Sel9; Size of array:C274(tl_xFMDis2))
ARRAY BOOLEAN:C223(tb_Sel10; Size of array:C274(tl_xFMDis5))
ARRAY BOOLEAN:C223(tb_Sel11; Size of array:C274(tl_xFMComp))

If (Bool:C1537(Form:C1466.maskedEmptyRow)=True:C214)
	outilsArrayVisibility(->tb_Sel1; ->t_CT_Total; ->tb_Sel2; ->t_ET_Dem; ->tb_Sel3; ->t_SG_Dem; ->tb_Sel4; ->tl_xGroupe; ->tb_Sel5; ->tl_xFMCaS; \
		->tb_Sel6; ->tl_xFMDis3; ->tb_Sel7; ->tl_xFMDis1; ->tb_Sel8; ->tl_xFMDis4; ->tb_Sel9; ->tl_xFMDis2; ->tb_Sel10; ->tl_xFMDis5; ->tb_Sel11; ->tl_xFMComp)
Else 
	outilsArrayVisibility(->tb_Sel1; False:C215; ->tb_Sel2; False:C215; ->tb_Sel3; False:C215; ->tb_Sel4; False:C215; ->tb_Sel5; False:C215; \
		->tb_Sel6; False:C215; ->tb_Sel7; False:C215; ->tb_Sel8; False:C215; ->tb_Sel9; False:C215; ->tb_Sel10; False:C215; ->tb_Sel11; False:C215)
End if 