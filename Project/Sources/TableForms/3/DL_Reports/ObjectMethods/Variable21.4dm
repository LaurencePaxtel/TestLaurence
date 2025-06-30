//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Script b_RpRepM
//{
//{          Mardi 13 Février 2001 à 11:55:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($nbJours)
C_BOOLEAN:C305($tuYva)

If (Form event code:C388=Sur clic:K2:4)
	
	If (vb_ReportAuto)
		ALERT:C41("Report automatique programmé !")
	Else 
		
		If ([DiaLogues:3]DL_Date:2>!00-00-00!)
			
			If ([DiaLogues:3]DL_Date:2#Current date:C33(*))  // Cela doit être la date d'aujourd'hui   
				ALERT:C41("La date doit correspondre à la date du jour !")
			Else 
				MESSAGES OFF:C175
				
				// 04/11/2008
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
				QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin)
				MultiSoc_Filter(->[HeberGement:5])
				// Fin 04/11/2008
				
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
				FIRST RECORD:C50([HeberGement:5])
				
				vd_R_DateJ:=[HeberGement:5]HG_Date:4
				
				Case of 
					: (vd_R_DateJ<[DiaLogues:3]DL_Date:2)
						$tuYva:=True:C214
					: (vd_R_DateJ=[DiaLogues:3]DL_Date:2)  // Déjà reportées  
						ALERT:C41("Les hébergements ont déjà été reportés à la date du "+String:C10([DiaLogues:3]DL_Date:2)+" !")
					: (vd_R_DateJ>[DiaLogues:3]DL_Date:2)  // La base de données contient des reports au vd_R_DateJ    
						ALERT:C41("Des hébergements postérieurs à la date du "+String:C10([DiaLogues:3]DL_Date:2)+" ont déjà été reportés!")
				End case 
				
				If ($tuYva)
					
					If (i_Confirmer("Confirmez les reports  à compter du "+String:C10(vd_R_DateJ)+" jusqu'au "+String:C10([DiaLogues:3]DL_Date:2)))
						$nbJours:=[DiaLogues:3]DL_Date:2-vd_R_DateJ
						
						For ($ii; 1; $nbJours)
							vd_R_DateJ:=vd_R_DateJ+1
							
							P_ReportRec1(vd_R_DateJ)
							P_ReportRetard(vd_R_DateJ)
						End for 
						
					End if 
					
				End if 
				
			End if 
			
			// 04/11/2008
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
			QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin)
			MultiSoc_Filter(->[HeberGement:5])
			// Fin 04/11/2008
			
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
			FIRST RECORD:C50([HeberGement:5])
			
			vd_R_DateJ:=[HeberGement:5]HG_Date:4
			vd_R_DateJ:=vd_R_DateJ+1
			
			P_ReportRec1(vd_R_DateJ)
			vL_NbFiches:=Records in selection:C76([HeberGement:5])
			
			If (vL_NbFiches>0)
				P_HébergementReportSort
				
				FIRST RECORD:C50([HeberGement:5])
				PREVIOUS RECORD:C110([HeberGement:5])
			End if 
			
		End if 
		
	End if 
	
End if 