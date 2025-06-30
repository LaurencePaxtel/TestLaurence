If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(td_DocuDates)>0)
		If (td_DocuDates>0)
			
			vd_DateDocu:=td_DocuDates{td_DocuDates}
			P_BAL_B(2)
			If (Size of array:C274(tt_TransDocu)>0)
				tt_TransDocu:=1
			Else 
				// #BS Fix O par 0 - 150616
				tt_TransDocu:=0
			End if 
			P_BAL_B(3)
		End if 
	End if 
End if 