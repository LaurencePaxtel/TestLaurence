//%attributes = {}
QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[DossierPsycho:28]DY_HB_ID:10)
MultiSoc_Filter(->[HeBerge:4])
If (Records in selection:C76([HeBerge:4])=0)
	READ WRITE:C146([HeBerge:4])
	CREATE RECORD:C68([HeBerge:4])
	MultiSoc_Init_Structure(->[HeBerge:4])
	[HeBerge:4]HB_ReferenceID:1:=[DossierPsycho:28]DY_HB_ID:10
	[HeBerge:4]HB_Clé:2:=va_PréfixNew+Uut_HébergéClé(->[DossierPsycho:28]DY_Nom:13; ->[DossierPsycho:28]DY_Prénom:14; ->[DossierPsycho:28]DY_DateNéLe:16)
	[HeBerge:4]HB_Nom:3:=[DossierPsycho:28]DY_Nom:13
	[HeBerge:4]HB_Prénom:4:=[DossierPsycho:28]DY_Prénom:14
	[HeBerge:4]HB_DateNéLe:5:=[DossierPsycho:28]DY_DateNéLe:16
	[HeBerge:4]HG_Genre:39:=[DossierPsycho:28]DY_Genre:18
	[HeBerge:4]HB_FicheCrééele:46:=Current date:C33(*)
	SAVE RECORD:C53([HeBerge:4])
	UNLOAD RECORD:C212([HeBerge:4])
	READ ONLY:C145([HeBerge:4])
End if 