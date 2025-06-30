If (Form event code:C388=Sur clic:K2:4)
	MESSAGES ON:C181
	
	$ve_QuelCas:=0
	
	If (va_HGRPré>"")
		$ve_QuelCas:=1
	End if 
	If (vd_HGRNé>!00-00-00!)
		$ve_QuelCas:=2
	End if 
	If (va_HGRPré>"") & (vd_HGRNé>!00-00-00!)
		$ve_QuelCas:=3
	End if 
	If ($ve_QuelCas>0)
		Case of 
			: ($ve_QuelCas=1)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=va_HGRPré)
			: ($ve_QuelCas=2)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_DateNéLe:5=vd_HGRNé)
			: ($ve_QuelCas=3)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=va_HGRPré; *)
				QUERY:C277([HeBerge:4];  & [HeBerge:4]HB_DateNéLe:5=vd_HGRNé)
		End case 
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		FIRST RECORD:C50([HeBerge:4])
		PREVIOUS RECORD:C110([HeBerge:4])
	Else 
		REDUCE SELECTION:C351([HeBerge:4]; 0)
	End if 
	va_NNN:=""
	vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
	REDUCE SELECTION:C351([HeberGement:5]; 0)
	vL_Nb_HG_F:=0
	MESSAGES OFF:C175
	
	P_HébergementNotesBt(0)
	OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
End if 