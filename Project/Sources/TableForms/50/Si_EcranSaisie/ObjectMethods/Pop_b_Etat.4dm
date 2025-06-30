If (F_Tab_Pop("Etat"; -><>ta_SIAO_Etat; ->[SIAO:50]Si_Etat_Type:41))
	If ([SIAO:50]Si_Etat_Type:41#Old:C35([SIAO:50]Si_Etat_Type:41))
		[SIAO:50]Si_Etat_Date:42:=Current date:C33
	End if 
End if 