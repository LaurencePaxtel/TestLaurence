$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur impression corps:K2:18)
		ve_Hsex:=Num:C11([HeBerge:4]HG_Genre:39=True:C214)
		
		//va_QuellesStats:="DIR"
		//va_QuellesStats:="CTR"
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1; *)
		MultiSoc_Filter(->[HeberGement:5])
		If (va_QuellesStats="CTR")
			QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_LC_ID:61=t_CT_ID{ta_Centre}; *)
			MultiSoc_Filter(->[HeberGement:5])
		End if 
		If (vd_Date1=vd_Date2)
			QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Date:4=vd_Date1; *)
			MultiSoc_Filter(->[HeberGement:5])
		Else 
			QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Date:4>=vd_Date1; *)
			QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Date:4<=vd_Date2; *)
			MultiSoc_Filter(->[HeberGement:5])
		End if 
		QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Cloturée:67=True:C214)
		MultiSoc_Filter(->[HeberGement:5])
		vl_HNb:=Records in selection:C76([HeberGement:5])
		
	: ($vl_EventFF=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 
