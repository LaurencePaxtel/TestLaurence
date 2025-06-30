C_POINTER:C301($P_Phone)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		QUERY:C277([HeBerge:4])
		MultiSoc_Filter(->[HeBerge:4])
		
		If (OK=1)
			vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
			vL_Nb_HG_F:=0
			va_NNN:=""
			
			REDUCE SELECTION:C351([HeberGement:5]; 0)
			ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
			
			UNLOAD RECORD:C212([HeBerge:4])
			
			P_HébergementNotesBt(0)
			OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
			
			va_FrappeClavier:=""
			va_HGRNom:=""
			va_HGRPré:=""
			vd_HGRNé:=!00-00-00!
			
			$P_Phone:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "telephone")  // ajouté 20/01/2017
			$P_Phone->:=""
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 