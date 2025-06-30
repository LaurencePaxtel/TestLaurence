If (Form event code:C388=Sur affichage corps:K2:22)
	va_Rép2:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
	If ([HeberGement:5]HG_FamGroupe:102="") | ([HeberGement:5]HG_FamGroupe:102="115")
		va_Gpe:=""
	Else 
		va_Gpe:="DA"
		If ([HeberGement:5]HG_FamChef:103)
			OBJECT SET FONT STYLE:C166(va_Gpe; 4)
		Else 
			OBJECT SET FONT STYLE:C166(va_Gpe; 0)
		End if 
	End if 
	
End if 