//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Fusion
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
[HeberGement:5]HG_HB_ID:19:=vl_IDT_Réf1
[HeberGement:5]HG_Nom:21:=va_FusNom
[HeberGement:5]HG_Prénom:22:=va_FusPré
[HeberGement:5]HG_DateNéLe:24:=vd_FusNé
[HeberGement:5]HG_Genre:96:=vb_FusSex

If (Year of:C25([HeberGement:5]HG_DateNéLe:24)>0)
	
	If (Month of:C24([HeberGement:5]HG_Date:4)>Month of:C24([HeberGement:5]HG_DateNéLe:24))
		[HeberGement:5]HG_Age:23:=Year of:C25([HeberGement:5]HG_Date:4)-Year of:C25([HeberGement:5]HG_DateNéLe:24)
	Else 
		[HeberGement:5]HG_Age:23:=Year of:C25([HeberGement:5]HG_Date:4)-Year of:C25([HeberGement:5]HG_DateNéLe:24)-1
	End if 
	
End if 