//%attributes = {}
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
MultiSoc_Filter(->[HeberGement:5])
If (Records in selection:C76([HeberGement:5])>0)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
	FIRST RECORD:C50([HeberGement:5])
	[HeBerge:4]HB_FicheCrééele:46:=[HeberGement:5]HG_Date:4
End if 