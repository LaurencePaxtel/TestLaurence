$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur entête:K2:17)
		ve_LC_Pg:=Printing page:C275
	: ($vl_EventFF=Sur impression corps:K2:18)
		
		va_faxASol:=[HeberGement:5]HG_AutreSolutio:88+" "+[HeberGement:5]HG_AutreSolSuite:123
		
		va_LC_Res:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
		If ([HeberGement:5]HG_NuitenCours:92>1)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_FicheNuméro:3; Italique:K14:3)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_EtatCivil:20; Italique:K14:3)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Nom:21; Italique:K14:3)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Prénom:22; Italique:K14:3)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Age:23; Italique:K14:3)
			vl_Nouveau:=0
			va_Nouveau:=""
		Else 
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_FicheNuméro:3; Normal:K14:1)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_EtatCivil:20; Normal:K14:1)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Nom:21; Normal:K14:1)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Prénom:22; Normal:K14:1)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Age:23; Normal:K14:1)
			vl_Nouveau:=1
			va_Nouveau:="N"
			If ([HeberGement:5]HG_ER_Remplaçant:130)
				va_Nouveau:="Rp"
			End if 
		End if 
		If ([HeberGement:5]HG_ER_Excuse:124)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_FicheNuméro:3; Gras:K14:2+Italique:K14:3)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_EtatCivil:20; Gras:K14:2+Italique:K14:3)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Nom:21; Gras:K14:2+Italique:K14:3)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Prénom:22; Gras:K14:2+Italique:K14:3)
			OBJECT SET FONT STYLE:C166([HeberGement:5]HG_Age:23; Gras:K14:2+Italique:K14:3)
			
			va_Nouveau:="E"
			OBJECT SET VISIBLE:C603(*; "Std_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "NE_@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "Std_@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "NE_@"; False:C215)
		End if 
		
		
		
End case 