If (Form event code:C388=Sur affichage corps:K2:22)
	If ([HeberGement:5]HG_Genre:96=True:C214)
		va_sex:="F"
	Else 
		va_sex:="M"
	End if 
	If ([HeberGement:5]HG_Réservation:91=True:C214)
		va_Rés:="o"
	Else 
		va_Rés:=""
	End if 
	
	If ([HeberGement:5]HG_Cloturée:67=True:C214)
		va_Clo:="C"
	Else 
		va_Clo:=""
	End if 
	
End if 