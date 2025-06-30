$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur entête:K2:17)
		va_LC_Res:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
		va_TheAge:=""
		vd_TheAge:=Current date:C33
		va_TheAge:=String:C10(Uut_HébergéAgePlus(->[HeberGement:5]HG_DateNéLe:24; ->vd_TheAge))
	: ($vl_EventFF=Sur impression corps:K2:18)
		If ([HeberGement:5]HG_NuitTOTAL:93>1)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_FicheNuméro:3; 2)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_EtatCivil:20; 2)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Nom:21; 2)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Prénom:22; 2)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Age:23; 2)
		Else 
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_FicheNuméro:3; 0)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_EtatCivil:20; 0)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Nom:21; 0)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Prénom:22; 0)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Age:23; 0)
		End if 
End case 
