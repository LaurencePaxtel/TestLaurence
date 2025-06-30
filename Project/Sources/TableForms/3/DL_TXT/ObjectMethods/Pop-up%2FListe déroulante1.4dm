

If (ta_STR>0)
	If (ta_STR{ta_STR}=ta_STR{0})
	Else 
		//Enregistrement
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP))
			TableTXT(4; 0)
		End if 
		//Synchronisation
		TableTXT(1; ta_STR)
		//Chargement
		TableTXT(3; ta_STR)
	End if 
Else 
	ta_STR:=Find in array:C230(ta_STR; ta_STR{0})
End if 