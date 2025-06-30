//%attributes = {}
[SIAO_Personnes:51]Sp_Nom:11:=va_IDT_Nom
[SIAO_Personnes:51]Sp_Prenom:13:=va_IDT_Pré
[SIAO_Personnes:51]Sp_Date_de_naissance:14:=vd_IDT_NéLe
QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=[SIAO_Personnes:51]Sp_SIAO_ID:2)
MultiSoc_Filter(->[SIAO:50])
If (Records in selection:C76([SIAO:50])=1)
	[SIAO_Personnes:51]Sp_Age:15:=Uut_HébergéAgePlus(->[SIAO_Personnes:51]Sp_Date_de_naissance:14; ->[SIAO:50]Si_Demande_Date:2)
Else 
	vd_SIAO_UneDate:=Current date:C33
	[SIAO_Personnes:51]Sp_Age:15:=Uut_HébergéAgePlus(->[SIAO_Personnes:51]Sp_Date_de_naissance:14; ->vd_SIAO_UneDate)
End if 