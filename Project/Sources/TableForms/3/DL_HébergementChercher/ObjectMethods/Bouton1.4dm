If (Form event code:C388=Sur clic:K2:4)
	MESSAGES ON:C181
	
	C_POINTER:C301($P_Phone)
	$P_Phone:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "telephone")  // ajouté 20/01/2017
	
	$ve_QuelCas:=0
	
	If (va_HGRPré>"")
		$ve_QuelCas:=1
	End if 
	If (vd_HGRNé>!00-00-00!)
		$ve_QuelCas:=2
	End if 
	
	If ($P_Phone->#"")
		$ve_QuelCas:=4
	End if 
	
	If (va_HGRPré>"") & (vd_HGRNé>!00-00-00!)
		$ve_QuelCas:=3
	End if 
	
	
	
	
	If ($ve_QuelCas>0)
		Case of 
			: ($ve_QuelCas=1)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=(va_HGRPré+"@"))
			: ($ve_QuelCas=2)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_DateNéLe:5=vd_HGRNé)
			: ($ve_QuelCas=3)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=(va_HGRPré+"@"); *)
				QUERY:C277([HeBerge:4];  & [HeBerge:4]HB_DateNéLe:5=vd_HGRNé)
			: ($ve_QuelCas=4)
				QUERY BY FORMULA:C48([HeBerge:4]; ([HeBerge:4]HB_Telephone:66=$P_Phone->))
		End case 
		MultiSoc_Filter(->[HeBerge:4])
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		UNLOAD RECORD:C212([HeBerge:4])
		//FIRST RECORD([HeBerge])
		//PREVIOUS RECORD([HeBerge])
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


