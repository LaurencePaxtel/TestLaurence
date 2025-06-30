If (Form event code:C388=Sur affichage corps:K2:22)
	vl_NombreNR:=0
	va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
	
	vl_NombreNR:=F_HébergementRubNR(<>vlSTR_Std-<>vlSTR)
End if 