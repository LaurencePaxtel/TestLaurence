If (Form event code:C388=Sur clic:K2:4)
	
	va_IDT_LienFam:=""
	
	va_IDT_Typ1:=""
	
	va_IDT_Clé:=""
	va_IDT_Nom:=""
	va_IDT_Pré:=""
	vd_IDT_NéLe:=!00-00-00!
	ve_IDT_Age:=0
	
	rIDTG_1:=1
	rIDTG_2:=0
	
	x_IDTG_1:=rIDTG_1
	x_IDTG_2:=rIDTG_2
	
	ve_IDT_PCAge:=0
	
	va_FrappeClavier:=""
	REDUCE SELECTION:C351([HeBerge:4]; 0)
	vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
	FIRST RECORD:C50([HeBerge:4])
	REDUCE SELECTION:C351([HeberGement:5]; 0)
	vL_Nb_HG_F:=0
	P_HébergementNotesBt(0)
	If (wresMulti=0)
		OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
	End if 
End if 