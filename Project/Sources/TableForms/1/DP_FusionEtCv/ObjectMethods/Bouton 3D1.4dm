If (Form event code:C388=Sur clic:K2:4)
	MESSAGES ON:C181
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_item1; *)
	QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Date:4<=vd_item2)
	MultiSoc_Filter(->[HeberGement:5])
	vl_itemNb:=Records in selection:C76([HeberGement:5])
	
End if 