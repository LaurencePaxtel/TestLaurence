

If (ta_STR>0)
	
	If (ta_STR{ta_STR}=ta_STR{0})
	Else 
		$ii:=Find in array:C230(tl_STRno; tl_STRno{0})
		//Enregistrement
		TableSTR(6; $ii)
		//Synchronisation
		TableSTR(1; ta_STR)
		//Chargement
		TableSTR(4; 0)
		TableSTR(2; 1)
	End if 
Else 
	ta_STR:=Find in array:C230(ta_STR; ta_STR{0})
End if 