//Formule format : HG_Li_Veille
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur impression corps:K2:18)
		va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
		va_Rép:=""
		If ([HeberGement:5]HG_NuitenCours:92>1)
			va_Rép:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
		End if 
	: ($vl_EventFF=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 
