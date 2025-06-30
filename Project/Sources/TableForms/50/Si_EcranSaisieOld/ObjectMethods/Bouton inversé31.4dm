If (F_UnReferent([SIAO:50]Si_OrigineSiteAccueil_ID:19; "Référent professionnel"))
	[SIAO:50]Si_OrigineSiteAccueil_ID:19:=vl_SIAO_Referent
	[SIAO:50]Si_Origine_SiteAccueil:18:=va_SIAO_Referent_Nom+" "+va_SIAO_Referent_Prénom
	REDRAW:C174([SIAO:50]Si_Origine_SiteAccueil:18)
End if 

