//Script b_EtatCivil



If (F_HébergéEtatCivil(7))
	[DossierSante:33]DE_EtatCivil:13:=va_IDT_Typ1
	[DossierSante:33]DE_Nom:14:=va_IDT_Nom
	[DossierSante:33]DE_Prénom:15:=va_IDT_Pré
	[DossierSante:33]DE_Age:16:=ve_IDT_Age
	[DossierSante:33]DE_DateNéLe:17:=vd_IDT_NéLe
	[DossierSante:33]DE_Genre:19:=(x_IDTG_2=1)
	va_Identité:=[DossierSante:33]DE_Nom:14+" "+[DossierSante:33]DE_Prénom:15
	
End if 
