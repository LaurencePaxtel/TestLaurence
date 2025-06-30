If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(td_DocuDates)>0)
		If (td_DocuDates>0)
			
			vd_DateDocu:=td_DocuDates{td_DocuDates}
			P_BAL_B(2)
		End if 
	End if 
End if 