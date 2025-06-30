If (User in group:C338(Current user:C182; <>Groupe_SIAOModDate) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	
	
	va_SIAO_UneDate:=String:C10([SIAO:50]Si_Demande_Date:2; Interne date court:K1:7)
	va_SIAO_UneDate:=Request:C163("Modification de la date du dossier"; va_SIAO_UneDate)
	If (OK=1)
		vd_SIAO_UneDate:=Date:C102(va_SIAO_UneDate)
		If (vd_SIAO_UneDate>!00-00-00!)
			If (vd_SIAO_UneDate=[SIAO:50]Si_Demande_Date:2)
			Else 
				[SIAO:50]Si_Demande_Date:2:=vd_SIAO_UneDate
				[SIAO:50]Si_Demande_Numero:3:=F_Site(<>va_T_Site)+F_SIAO_Numero([SIAO:50]Si_Demande_Date:2)
			End if 
		Else 
			ALERT:C41(va_SIAO_UneDate+" : veuillez saisir une date correcte.")
		End if 
	End if 
Else 
End if 