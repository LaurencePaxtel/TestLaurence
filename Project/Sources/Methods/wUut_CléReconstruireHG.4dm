//%attributes = {}
QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
MultiSoc_Filter(->[HeBerge:4])
If (Records in selection:C76([HeBerge:4])=0)
	READ WRITE:C146([HeBerge:4])
	CREATE RECORD:C68([HeBerge:4])
	MultiSoc_Init_Structure(->[HeBerge:4])
	[HeBerge:4]HB_ReferenceID:1:=[HeberGement:5]HG_HB_ID:19
	[HeBerge:4]HB_Clé:2:=va_PréfixNew+Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
	[HeBerge:4]HB_Nom:3:=[HeberGement:5]HG_Nom:21
	[HeBerge:4]HB_Prénom:4:=[HeberGement:5]HG_Prénom:22
	[HeBerge:4]HB_DateNéLe:5:=[HeberGement:5]HG_DateNéLe:24
	[HeBerge:4]HG_Genre:39:=[HeberGement:5]HG_Genre:96
	[HeBerge:4]HB_FicheCrééele:46:=Current date:C33(*)
	SAVE RECORD:C53([HeBerge:4])
	UNLOAD RECORD:C212([HeBerge:4])
	READ ONLY:C145([HeBerge:4])
End if 