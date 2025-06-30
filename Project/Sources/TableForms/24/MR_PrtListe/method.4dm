$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur impression corps:K2:18)
		va_NomClé:=Uut_HébergéClé(->[Maraude:24]MR_Nom:17; ->[Maraude:24]MR_Prénom:18; ->[Maraude:24]MR_DateNéLe:20)
		
	: ($vl_EventFF=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 
