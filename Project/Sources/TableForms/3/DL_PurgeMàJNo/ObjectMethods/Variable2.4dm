
va_LibNo:=""
vb_majOK:=False:C215
If (vl_majOK>0)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_majOK)
	MultiSoc_Filter(->[HeBerge:4])
	If (Records in selection:C76([HeBerge:4])=1)
		va_CléOK:=[HeBerge:4]HB_Clé:2
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[HeberGement:5])
		vl_NbOK:=Records in selection:C76([HeberGement:5])
		vb_majOK:=True:C214
	Else 
		va_CléOK:=String:C10(Records in selection:C76([HeBerge:4]))+" hébérge(s)"
		vl_NbOK:=0
	End if 
Else 
	va_CléOK:=""
	vl_NbOK:=0
End if 