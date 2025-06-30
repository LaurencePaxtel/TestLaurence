//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FusionSté
//{
//{          Vendrdi 26 novembre 2004 à 18:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
[DossierSante:33]DE_HB_ID:10:=vl_IDT_Réf1
[DossierSante:33]DE_Nom:14:=va_FusNom
[DossierSante:33]DE_Prénom:15:=va_FusPré
[DossierSante:33]DE_DateNéLe:17:=vd_FusNé
[DossierSante:33]DE_Genre:19:=vb_FusSex

If (Year of:C25([DossierSante:33]DE_DateNéLe:17)>0)
	
	If (Month of:C24([DossierSante:33]DE_Date:4)>Month of:C24([DossierSante:33]DE_DateNéLe:17))
		[DossierSante:33]DE_Age:16:=Year of:C25([DossierSante:33]DE_Date:4)-Year of:C25([DossierSante:33]DE_DateNéLe:17)
	Else 
		[DossierSante:33]DE_Age:16:=Year of:C25([DossierSante:33]DE_Date:4)-Year of:C25([DossierSante:33]DE_DateNéLe:17)-1
	End if 
	
End if 