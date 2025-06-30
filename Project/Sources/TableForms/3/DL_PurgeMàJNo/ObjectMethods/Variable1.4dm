
va_LibNo:=""
vb_majWrong:=False:C215
If (vl_majWrong>0)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_majWrong)
	MultiSoc_Filter(->[HeBerge:4])
	If (Records in selection:C76([HeBerge:4])=1)
		va_CléWrong:=[HeBerge:4]HB_Clé:2
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_majWrong)
		MultiSoc_Filter(->[HeberGement:5])
		vl_NbWrong:=Records in selection:C76([HeberGement:5])
		vb_majWrong:=True:C214
	Else 
		va_CléWrong:=String:C10(Records in selection:C76([HeBerge:4]))+" hébérge(s)"
		vl_NbWrong:=0
	End if 
Else 
	va_CléWrong:=""
	vl_NbWrong:=0
End if 