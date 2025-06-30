// Method [DiaLogues].DL_BDOS.Bouton image  
// 

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (F_PlageEnCours(ve_Date_Cas; 1; ->[DiaLogues:3]DL_Date:2; ->[DiaLogues:3]DL_Date2:8))
			P_SIAO_BDOS_Find
		End if 
End case 