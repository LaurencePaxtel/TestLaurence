
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If ([DiaLogues:3]DL_Date:2=!00-00-00!)
			[DiaLogues:3]DL_Date:2:=Current date:C33
		End if 
		
		If (F_PlageEnCours(ve_Date_Cas; -1; ->[DiaLogues:3]DL_Date:2; ->DL_Date_Au))
			
			If (<>vb_AvecProlongation)
				P_HébergementReportFindPR
			Else 
				P_HébergementReportFind
			End if 
			
		End if 
		
End case 

