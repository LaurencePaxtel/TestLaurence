//%attributes = {}
var $champType_el : Integer

GET FIELD PROPERTIES:C258(tp_ItemRub{ta_ItemRub}; $champType_el)

Case of 
	: ($champType_el=Est une date:K8:7)
		tp_ItemRub{ta_ItemRub}->:=Date:C102(va_IDT_Typ1)
	: ($champType_el=Est un booléen:K8:9)
		
		Case of 
			: (outilsCheckStringIsNumber(va_IDT_Typ1)=True:C214)
				tp_ItemRub{ta_ItemRub}->:=Bool:C1537(Num:C11(va_IDT_Typ1))
			: (va_IDT_Typ1="Vrai")
				tp_ItemRub{ta_ItemRub}->:=True:C214
			Else 
				tp_ItemRub{ta_ItemRub}->:=False:C215
		End case 
		
	: ($champType_el=Est un numérique:K8:4) | ($champType_el=Est un entier long:K8:6) | ($champType_el=Est un entier:K8:5)
		tp_ItemRub{ta_ItemRub}->:=Num:C11(va_IDT_Typ1)
	Else 
		tp_ItemRub{ta_ItemRub}->:=va_IDT_Typ1
End case 

If (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Plateforme:139))
	F_Report_FullPlateforme(->[HeberGement:5]HG_Trans_DDASS:141; [HeberGement:5]HG_Plateforme:139)
End if 

If (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_CentreNom:62))
	[HeberGement:5]HG_LC_ID:61:=<>vl_TBItemCtreID
End if 