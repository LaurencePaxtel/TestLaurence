//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FusionMaraude
//{
//{          Vendrdi 26 novembre 2004 à 18:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
[Maraude:24]MR_HB_ID:10:=vl_IDT_Réf1
[Maraude:24]MR_Nom:17:=va_FusNom
[Maraude:24]MR_Prénom:18:=va_FusPré
[Maraude:24]MR_DateNéLe:20:=vd_FusNé
[Maraude:24]MR_Genre:42:=vb_FusSex

If (Year of:C25([Maraude:24]MR_DateNéLe:20)>0)
	
	If (Month of:C24([Maraude:24]MR_Date:4)>Month of:C24([Maraude:24]MR_DateNéLe:20))
		[Maraude:24]MR_Age:19:=Year of:C25([Maraude:24]MR_Date:4)-Year of:C25([Maraude:24]MR_DateNéLe:20)
	Else 
		[Maraude:24]MR_Age:19:=Year of:C25([Maraude:24]MR_Date:4)-Year of:C25([Maraude:24]MR_DateNéLe:20)-1
	End if 
	
End if 