$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur impression corps:K2:18)
		va_NomClé:=Uut_HébergéClé(->[DossierSocial:25]DS_Nom:12; ->[DossierSocial:25]DS_Prénom:16; ->[DossierSocial:25]DS_DateNéLe:18)
		
	: ($vl_EventFF=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 
