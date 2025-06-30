If (va_CritèreAlpha="")
	va_CritèreAlpha:="@"
End if 
P_CentreSIAO(va_CritèreAlpha; ->vl_CentreSIAO_ID; ->[Dossier_SIAO:49]SI_Structure_d_accueil:23)
If (Character code:C91(va_CritèreAlpha)=Character code:C91("@"))
	va_CritèreAlpha:=""
End if 