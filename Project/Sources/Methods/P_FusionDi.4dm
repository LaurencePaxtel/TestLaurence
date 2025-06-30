//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FusionDi
//{
//{          Vendrdi 26 novembre 2004 à 18:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
[DossierInfirmie:27]DI_HB_ID:10:=vl_IDT_Réf1
[DossierInfirmie:27]DI_Nom:13:=va_FusNom
[DossierInfirmie:27]DI_Prénom:14:=va_FusPré
[DossierInfirmie:27]DI_DateNéLe:16:=vd_FusNé
[DossierInfirmie:27]DI_Genre:18:=vb_FusSex

If (Year of:C25([DossierInfirmie:27]DI_DateNéLe:16)>0)
	
	If (Month of:C24([DossierInfirmie:27]DI_Date:4)>Month of:C24([DossierInfirmie:27]DI_DateNéLe:16))
		[DossierInfirmie:27]DI_Age:15:=Year of:C25([DossierInfirmie:27]DI_Date:4)-Year of:C25([DossierInfirmie:27]DI_DateNéLe:16)
	Else 
		[DossierInfirmie:27]DI_Age:15:=Year of:C25([DossierInfirmie:27]DI_Date:4)-Year of:C25([DossierInfirmie:27]DI_DateNéLe:16)-1
	End if 
	
End if 