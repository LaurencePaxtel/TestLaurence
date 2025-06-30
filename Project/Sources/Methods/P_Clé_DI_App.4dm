//%attributes = {}
[DossierInfirmie:27]DI_Nom:13:=va_IDT_Nom
[DossierInfirmie:27]DI_Prénom:14:=va_IDT_Pré
[DossierInfirmie:27]DI_DateNéLe:16:=vd_IDT_NéLe
[DossierInfirmie:27]DI_Age:15:=Uut_HébergéAgePlus(->[DossierInfirmie:27]DI_DateNéLe:16; ->[DossierInfirmie:27]DI_Date:4)
