If (Form event code:C388=Sur clic:K2:4)
	QUERY:C277([HeBerge:4])
	If (OK=1)
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		va_NNN:=""
	End if 
	P_HébergementRGFind(-1)
	P_HébergementNotesBt(0)
	OBJECT SET ENABLED:C1123(b_PrestNew; False:C215)
	OBJECT SET ENABLED:C1123(b_PrestMod; False:C215)
	OBJECT SET ENABLED:C1123(b_PrestSup; False:C215)
	OBJECT SET ENABLED:C1123(b_PrestImp; False:C215)
End if 