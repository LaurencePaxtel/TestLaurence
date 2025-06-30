If (Form event code:C388=Sur clic:K2:4)
	va_HGRNom:="@"
	va_FrappeClavier:=va_HGRNom
	If (va_FrappeClavier="")
		REDUCE SELECTION:C351([HeBerge:4]; 0)
	Else 
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_FrappeClavier+"@"))
	End if 
	vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
	FIRST RECORD:C50([HeBerge:4])
	REDUCE SELECTION:C351([HeberGement:5]; 0)
	vL_Nb_HG_F:=0
	va_NNN:=""
	P_HébergementNotesBt(0)
	OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
End if 