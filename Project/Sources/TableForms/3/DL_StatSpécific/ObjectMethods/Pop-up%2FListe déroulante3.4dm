
If (ta_Rub3>0)
	If (ta_Rub3{ta_Rub3}=ta_Rub3{0})
	Else 
		If (P_Item_Spécific(3; ta_Rub3))
			ta_Rub3{0}:=ta_Rub3{ta_Rub3}
			tp_Rub3{0}:=tp_Rub3{ta_Rub3}
			te_Rub3{0}:=te_Rub3{ta_Rub3}
		Else 
			ta_Rub3:=Find in array:C230(ta_Rub3; ta_Rub3{0})
		End if 
	End if 
Else 
	ta_Rub3:=Find in array:C230(ta_Rub3; ta_Rub3{0})
End if 