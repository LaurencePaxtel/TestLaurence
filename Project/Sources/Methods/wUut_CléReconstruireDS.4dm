//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 06/12/21, 18:22:33
// ----------------------------------------------------
// Méthode : wUut_CléReconstruireDS
// Description
// 
//
// Paramètres
// ----------------------------------------------------
QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[DossierSocial:25]DS_HB_ID:10)
MultiSoc_Filter(->[HeBerge:4])

If (Records in selection:C76([HeBerge:4])=0)
	READ WRITE:C146([HeBerge:4])
	
	CREATE RECORD:C68([HeBerge:4])
	MultiSoc_Init_Structure(->[HeBerge:4])
	
	[HeBerge:4]HB_ReferenceID:1:=[DossierSocial:25]DS_HB_ID:10
	
	[HeBerge:4]HB_Clé:2:=Uut_HébergéClé(->[DossierSocial:25]DS_Nom:12; ->[DossierSocial:25]DS_Prénom:16; ->[DossierSocial:25]DS_DateNéLe:18)
	[HeBerge:4]HB_Nom:3:=[DossierSocial:25]DS_Nom:12
	[HeBerge:4]HB_Prénom:4:=[DossierSocial:25]DS_Prénom:16
	[HeBerge:4]HB_DateNéLe:5:=[DossierSocial:25]DS_DateNéLe:18
	[HeBerge:4]HG_Genre:39:=[DossierSocial:25]DS_Genre:20
	[HeBerge:4]HB_FicheCrééele:46:=Current date:C33(*)
	
	SAVE RECORD:C53([HeBerge:4])
	UNLOAD RECORD:C212([HeBerge:4])
	
	READ ONLY:C145([HeBerge:4])
End if 