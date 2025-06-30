If (Form event code:C388=Sur clic:K2:4)
	If (P_DatesPlageEnCours(1; False:C215))
	End if 
	If (F_PlageEnCours(ve_Date_Cas; 0; ->[DiaLogues:3]DL_Date:2; ->[DiaLogues:3]DL_Date2:8))
		P_HébergementVeilleFind
	End if 
End if 
