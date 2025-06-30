//%attributes = {}

[DossierSocial:25]DS_Nom:12:=va_IDT_Nom
[DossierSocial:25]DS_Prénom:16:=va_IDT_Pré
[DossierSocial:25]DS_DateNéLe:18:=vd_IDT_NéLe
[DossierSocial:25]DS_Age:17:=Uut_HébergéAgePlus(->[DossierSocial:25]DS_DateNéLe:18; ->[DossierSocial:25]DS_Date:4)