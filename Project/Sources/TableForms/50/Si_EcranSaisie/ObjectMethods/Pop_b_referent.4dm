If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN))
	If (F_UnReferent([SIAO:50]Si_OrigineSiteAccueil_ID:19; "Site d'accueil"))
		[SIAO:50]Si_OrigineSiteAccueil_ID:19:=vl_SIAO_Referent
		[SIAO:50]Si_Origine_SiteAccueil:18:=va_SIAO_Referent_Nom+" "+va_SIAO_Referent_Prénom
		REDRAW:C174([SIAO:50]Si_Origine_SiteAccueil:18)
	End if 
	
	
Else 
	va_SIAO_Referent_NomPrenom:=""
	Tab_PopIn80("Liste des référents"; ->ta_SIAO_Referent_Nom; ->va_SIAO_Referent_NomPrenom)
	If (va_SIAO_Referent_NomPrenom>"")
		P_SIAO_Var(8; 0)
	End if 
	
End if 

