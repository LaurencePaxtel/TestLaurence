
If (ta_Rub4>0)
	If (ta_Rub4{ta_Rub4}=ta_Rub4{0})
	Else 
		If (P_Item_Spécific(4; ta_Rub4))
			ta_Rub4{0}:=ta_Rub4{ta_Rub4}
			tp_Rub4{0}:=tp_Rub4{ta_Rub4}
			te_Rub4{0}:=te_Rub4{ta_Rub4}
		Else 
			ta_Rub4:=Find in array:C230(ta_Rub4; ta_Rub4{0})
		End if 
	End if 
Else 
	ta_Rub4:=Find in array:C230(ta_Rub4; ta_Rub4{0})
End if 