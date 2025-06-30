If (vb_MRferme=False:C215)
	If (F_HébergéEtatCivil(2))
		[Maraude:24]MR_EtatCivil:16:=va_IDT_Typ1
		[Maraude:24]MR_Nom:17:=va_IDT_Nom
		[Maraude:24]MR_Prénom:18:=va_IDT_Pré
		[Maraude:24]MR_Age:19:=ve_IDT_Age
		[Maraude:24]MR_DateNéLe:20:=vd_IDT_NéLe
		[Maraude:24]MR_Genre:42:=(x_IDTG_2=1)
		va_Identité:=[Maraude:24]MR_Nom:17+" "+[Maraude:24]MR_Prénom:18
	End if 
End if 