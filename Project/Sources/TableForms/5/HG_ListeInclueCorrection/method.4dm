//Formule Format : ListeInclueCorrection
If (Form event code:C388=Sur affichage corps:K2:22)
	va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
	va_Item:=tp_ItemRub{ta_ItemRub}->
End if 