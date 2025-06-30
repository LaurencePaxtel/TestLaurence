

If (ta_TXT>0)
	If (ta_TXT{ta_TXT}=ta_TXT{0})
	Else 
		//Enregistrement    
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP))
			TableTXT(4; 0)
		End if 
		//Synchronisation
		//Chargement
		TableTXT(2; ta_TXT)
	End if 
Else 
	ta_TXT:=Find in array:C230(ta_TXT; ta_TXT{0})
End if 