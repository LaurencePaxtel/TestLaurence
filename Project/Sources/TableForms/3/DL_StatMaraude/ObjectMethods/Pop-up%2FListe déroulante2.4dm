
If (ta_Rub2>0)
	If (ta_Rub2{ta_Rub2}=ta_Rub2{0})
	Else 
		If (P_Item_Maraude(2; ta_Rub2))
			ta_Rub2{0}:=ta_Rub2{ta_Rub2}
			tp_Rub2{0}:=tp_Rub2{ta_Rub2}
			te_Rub2{0}:=te_Rub2{ta_Rub2}
		Else 
			ta_Rub2:=Find in array:C230(ta_Rub2; ta_Rub2{0})
		End if 
	End if 
Else 
	ta_Rub2:=Find in array:C230(ta_Rub2; ta_Rub2{0})
End if 