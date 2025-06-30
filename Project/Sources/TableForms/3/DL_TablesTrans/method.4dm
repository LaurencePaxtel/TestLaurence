If (Form event code:C388=Sur chargement:K2:1)
	OBJECT SET VISIBLE:C603(*; "Orient1Std"; True:C214)
	OBJECT SET VISIBLE:C603(*; "Orient1Rouge"; False:C215)
	
	If (7=8)
		OBJECT SET VISIBLE:C603(*; "BtRemplir"; (<>va_T_QuelleBoiteLettres=<>va_T_LaBoiteDalo))
	End if 
	td_DocuDates:=0
	ta_DocuDates:=0
	
	If (Size of array:C274(td_DocuDates)>0)
		td_DocuDates:=1
		ta_DocuDates:=1
		vd_DateDocu:=td_DocuDates{td_DocuDates}
		P_BAL_B(2)
	End if 
End if 