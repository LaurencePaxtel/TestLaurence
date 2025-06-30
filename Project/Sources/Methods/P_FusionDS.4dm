//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FusionDS
//{
//{          Vendrdi 26 novembre 2004 à 18:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
[DossierSocial:25]DS_HB_ID:10:=vl_IDT_Réf1
[DossierSocial:25]DS_Nom:12:=va_FusNom
[DossierSocial:25]DS_Prénom:16:=va_FusPré
[DossierSocial:25]DS_DateNéLe:18:=vd_FusNé
[DossierSocial:25]DS_Genre:20:=vb_FusSex

If (Year of:C25([DossierSocial:25]DS_DateNéLe:18)>0)
	
	If (Month of:C24([Maraude:24]MR_Date:4)>Month of:C24([DossierSocial:25]DS_DateNéLe:18))
		[DossierSocial:25]DS_Age:17:=Year of:C25([DossierSocial:25]DS_Date:4)-Year of:C25([DossierSocial:25]DS_DateNéLe:18)
	Else 
		[DossierSocial:25]DS_Age:17:=Year of:C25([DossierSocial:25]DS_Date:4)-Year of:C25([DossierSocial:25]DS_DateNéLe:18)-1
	End if 
	
End if 