If (Form event code:C388=Sur affichage corps:K2:22)
	va_Envoi:=""
	If ([HeberGement:5]HG_1_TransHeure:70>?00:00:00?)
		va_Envoi:=String:C10([HeberGement:5]HG_1_TransHeure:70; h mn:K7:2)
	Else 
		
	End if 
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
	
	If ([HeberGement:5]HG_ER_Excuse:124)
		OBJECT SET VISIBLE:C603(*; "Std_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "NE_@"; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*; "Std_@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "NE_@"; False:C215)
	End if 
End if 