If (Form event code:C388=Sur clic:K2:4)
	MESSAGES ON:C181
	
	$ve_QuelCas:=0
	
	If (va_IDT_Pré>"")
		$ve_QuelCas:=1
	End if 
	If (vd_IDT_NéLe>!00-00-00!)
		$ve_QuelCas:=2
	End if 
	If (va_IDT_Pré>"") & (vd_IDT_NéLe>!00-00-00!)
		$ve_QuelCas:=3
	End if 
	If ($ve_QuelCas>0)
		Case of 
			: ($ve_QuelCas=1)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=(va_IDT_Pré+"@"))
			: ($ve_QuelCas=2)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_DateNéLe:5=vd_IDT_NéLe)
			: ($ve_QuelCas=3)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=(va_IDT_Pré+"@"); *)
				QUERY:C277([HeBerge:4];  & [HeBerge:4]HB_DateNéLe:5=vd_IDT_NéLe)
		End case 
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		FIRST RECORD:C50([HeBerge:4])
		PREVIOUS RECORD:C110([HeBerge:4])
	Else 
		REDUCE SELECTION:C351([HeBerge:4]; 0)
	End if 
	vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
	REDUCE SELECTION:C351([HeberGement:5]; 0)
	vL_Nb_HG_F:=0
	va_NNN:=""
	MESSAGES OFF:C175
	
	P_HébergementNotesBt(0)
End if 