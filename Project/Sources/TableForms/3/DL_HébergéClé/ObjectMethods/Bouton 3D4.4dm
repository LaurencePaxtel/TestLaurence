If (Form event code:C388=Sur clic:K2:4)
	QUERY:C277([HeBerge:4])
	If (OK=1)
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		vL_Nb_HG_F:=0
		va_NNN:=""
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		FIRST RECORD:C50([HeBerge:4])
		PREVIOUS RECORD:C110([HeBerge:4])
		
		va_FrappeClavier:=""
		va_HGRNom:=""
		va_HGRPré:=""
		vd_HGRNé:=!00-00-00!
	End if 
End if 