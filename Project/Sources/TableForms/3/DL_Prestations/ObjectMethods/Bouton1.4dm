If (Form event code:C388=Sur clic:K2:4)
	
	va_IDT_Typ1:=""
	
	va_IDT_Clé:=""
	va_IDT_Nom:=""
	va_IDT_Pré:=""
	vd_IDT_NéLe:=!00-00-00!
	ve_IDT_Age:=0
	
	C_POINTER:C301($P_Phone)
	$P_Phone:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "telephone")  // ajouté 20/01/2017
	
	$P_Phone->:=""
	
	rIDTG_1:=1
	rIDTG_2:=0
	
	x_IDTG_1:=rIDTG_1
	x_IDTG_2:=rIDTG_2
	
End if 