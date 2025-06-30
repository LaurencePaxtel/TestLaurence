If (ta_Rub1>0)
	
	If (ta_Rub1{ta_Rub1}=ta_Rub1{0})
	Else 
		
		If (P_Item_Spécific(1; ta_Rub1))
			ta_Rub1{0}:=ta_Rub1{ta_Rub1}
			tp_Rub1{0}:=tp_Rub1{ta_Rub1}
			te_Rub1{0}:=te_Rub1{ta_Rub1}
		Else 
			ta_Rub1:=Find in array:C230(ta_Rub1; ta_Rub1{0})
		End if 
		
	End if 
	
Else 
	ta_Rub1:=Find in array:C230(ta_Rub1; ta_Rub1{0})
End if 