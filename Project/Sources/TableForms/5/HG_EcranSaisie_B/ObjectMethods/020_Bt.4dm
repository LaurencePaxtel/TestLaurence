If (F_HébergéEtatCivil(1))
	[HeberGement:5]HG_EtatCivil:20:=va_IDT_Typ1
	[HeberGement:5]HG_Nom:21:=va_IDT_Nom
	[HeberGement:5]HG_Prénom:22:=va_IDT_Pré
	[HeberGement:5]HG_Age:23:=ve_IDT_Age
	[HeberGement:5]HG_DateNéLe:24:=vd_IDT_NéLe
	[HeberGement:5]HG_Genre:96:=(x_IDTG_2=1)
	
	va_Identité:=[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22
	
	[HeberGement:5]HG_YaFicheLiée:78:=(rIDTFL1=1)
	[HeberGement:5]HG_NbFicheLiée:79:=ve_IDT_NbFL
	[HeberGement:5]HG_1erFicheLiée:80:=(sIDTFL1=1)
	[HeberGement:5]HG_TypFicheLiée:81:=ve_IDT_TyFL
End if 