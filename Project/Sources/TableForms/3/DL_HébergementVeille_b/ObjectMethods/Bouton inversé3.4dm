Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (F_PlageEnCours(ve_Date_Cas; -1; ->[DiaLogues:3]DL_Date:2; ->[DiaLogues:3]DL_Date2:8))
			P_HébergementVeilleFind
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 