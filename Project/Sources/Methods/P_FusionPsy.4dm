//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FusionPsy
//{
//{          Vendrdi 26 novembre 2004 à 18:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
[DossierPsycho:28]DY_HB_ID:10:=vl_IDT_Réf1
[DossierPsycho:28]DY_Nom:13:=va_FusNom
[DossierPsycho:28]DY_Prénom:14:=va_FusPré
[DossierPsycho:28]DY_DateNéLe:16:=vd_FusNé
[DossierPsycho:28]DY_Genre:18:=vb_FusSex

If (Year of:C25([DossierPsycho:28]DY_DateNéLe:16)>0)
	
	If (Month of:C24([DossierPsycho:28]DY_Date:4)>Month of:C24([DossierPsycho:28]DY_DateNéLe:16))
		[DossierPsycho:28]DY_Age:15:=Year of:C25([DossierPsycho:28]DY_Date:4)-Year of:C25([DossierPsycho:28]DY_DateNéLe:16)
	Else 
		[DossierPsycho:28]DY_Age:15:=Year of:C25([DossierPsycho:28]DY_Date:4)-Year of:C25([DossierPsycho:28]DY_DateNéLe:16)-1
	End if 
	
End if 