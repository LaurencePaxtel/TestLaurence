va_SIAO_Referent_NomPrenom:=""
Tab_PopIn80("Liste des référents"; ->ta_SIAO_Referent_Nom; ->va_SIAO_Referent_NomPrenom)
If (va_SIAO_Referent_NomPrenom>"")
	P_SIAO_Var(6; 0)
End if 
