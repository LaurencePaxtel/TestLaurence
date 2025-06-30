If (Form event code:C388=Sur clic:K2:4)
	If ((b_New=1) & ([DiaLogues:3]DL_Date:2>!00-00-00!))
		P_DisponibilitéNew([DiaLogues:3]DL_Date:2; 1; Num:C11(<>vb_AvecProlongation))
	End if 
End if 