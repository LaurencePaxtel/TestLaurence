//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FusionMed
//{
//{          Vendrdi 26 novembre 2004 à 18:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
[DossierMedical:29]DM_HB_ID:10:=vl_IDT_Réf1
[DossierMedical:29]DM_Nom:13:=va_FusNom
[DossierMedical:29]DM_Prénom:14:=va_FusPré
[DossierMedical:29]DM_DateNéLe:16:=vd_FusNé
[DossierMedical:29]DM_Genre:18:=vb_FusSex

If (Year of:C25([DossierMedical:29]DM_DateNéLe:16)>0)
	
	If (Month of:C24([DossierMedical:29]DM_Date:4)>Month of:C24([DossierMedical:29]DM_DateNéLe:16))
		[DossierMedical:29]DM_Age:15:=Year of:C25([DossierMedical:29]DM_Date:4)-Year of:C25([DossierMedical:29]DM_DateNéLe:16)
	Else 
		[DossierMedical:29]DM_Age:15:=Year of:C25([DossierMedical:29]DM_Date:4)-Year of:C25([DossierMedical:29]DM_DateNéLe:16)-1
	End if 
	
End if 