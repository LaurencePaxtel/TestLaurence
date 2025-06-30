//%attributes = {}
[SIAO_Personnes:51]Sp_Nom:11:=va_IDT_Nom
[SIAO_Personnes:51]Sp_Prenom:13:=va_IDT_Pré
[SIAO_Personnes:51]Sp_Date_de_naissance:14:=vd_IDT_NéLe
[SIAO_Personnes:51]Sp_Age:15:=Uut_HébergéAgePlus(->[SIAO_Personnes:51]Sp_Date_de_naissance:14; ->[SIAO:50]Si_Demande_Date:2)