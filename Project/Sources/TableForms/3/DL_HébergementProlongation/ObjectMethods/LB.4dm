// Method [DiaLogues].DL_HébergementGpeNew.LB  
// 
C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=(-><>ta_GpP_Clé))
				
				If (Size of array:C274(<>ta_GpP_Clé)>0)
					vL_Nb_HG_F:=0
					va_NNN:=""
					REDUCE SELECTION:C351([HeberGement:5]; 0)
					If (<>ta_GpP_Clé>0)
						va_FrappeClavier:=""
						va_IDT_Nom:=""
						va_IDT_Pré:=""
						vd_IDT_NéLe:=!00-00-00!
						ve_IDT_Age:=0
						ve_IDT_PCAge:=0
						va_IDT_Clé:=<>ta_GpP_Clé{<>ta_GpP_Clé}
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>ta_GpP_Clé{<>ta_GpP_Clé})
						MultiSoc_Filter(->[HeBerge:4])
						If (Records in selection:C76([HeBerge:4])=1)
							vL_Nb_HG_F:=0
							va_NNN:=F_AfficheCléHébergé
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
							MultiSoc_Filter(->[HeberGement:5])
							vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
							ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
							ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
							//FIRST RECORD([HeberGement])
							PREVIOUS RECORD:C110([HeberGement:5])
							
						End if 
						
					End if 
				End if 
			Else 
				// rien
		End case 
		
		
		
	: (Form event code:C388=Sur double clic:K2:5)
		
		
		Case of 
			: ($P_Col_current=(-><>te_GpP_Check))
				
				If (Size of array:C274(<>te_GpP_Check)>0)
					If (<>te_GpP_Check>0)
						If (<>te_GpP_Check{<>te_GpP_Check}=1)
							<>te_GpP_Check{<>te_GpP_Check}:=0
						Else 
							<>te_GpP_Check{<>te_GpP_Check}:=1
						End if 
						va_GPmembres:=F_HébergementGroupeProlong([GrouPe:36]GP_Intitulé:4)
					End if 
				End if 
				
				
				
			Else 
				// rien
		End case 
		
End case 





