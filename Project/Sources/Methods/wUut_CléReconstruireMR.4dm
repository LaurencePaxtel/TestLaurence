//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/12/21, 15:05:44
// ----------------------------------------------------
// Méthode : wUut_CléReconstruireMR
// Description
// 
//
// Paramètres
// ----------------------------------------------------
QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Maraude:24]MR_HB_ID:10)
MultiSoc_Filter(->[HeBerge:4])

If (Records in selection:C76([HeBerge:4])=0)
	READ WRITE:C146([HeBerge:4])
	
	CREATE RECORD:C68([HeBerge:4])
	MultiSoc_Init_Structure(->[HeBerge:4])
	
	[HeBerge:4]HB_ReferenceID:1:=[Maraude:24]MR_HB_ID:10
	[HeBerge:4]HB_Clé:2:=Uut_HébergéClé(->[Maraude:24]MR_Nom:17; ->[Maraude:24]MR_Prénom:18; ->[Maraude:24]MR_DateNéLe:20)
	[HeBerge:4]HB_Nom:3:=[Maraude:24]MR_Nom:17
	[HeBerge:4]HB_Prénom:4:=[Maraude:24]MR_Prénom:18
	[HeBerge:4]HB_DateNéLe:5:=[Maraude:24]MR_DateNéLe:20
	[HeBerge:4]HG_Genre:39:=[Maraude:24]MR_Genre:42
	[HeBerge:4]HB_FicheCrééele:46:=Current date:C33(*)
	
	SAVE RECORD:C53([HeBerge:4])
	UNLOAD RECORD:C212([HeBerge:4])
	
	READ ONLY:C145([HeBerge:4])
End if 