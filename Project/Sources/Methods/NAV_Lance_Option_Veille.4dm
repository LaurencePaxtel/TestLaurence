//%attributes = {}
If (Accès_Groupe(<>Groupe_OptVeille))
	
	If (<>vb_UserLOFT)
		//CHOIX VISIBLE(*;"OptVeille_@";Faux)
		StrAlerte(6; "")
	Else 
		//CHOIX VISIBLE(*;"OptVeille_@";Vrai)
		Go_OptionVeille
	End if 
	
	
End if 