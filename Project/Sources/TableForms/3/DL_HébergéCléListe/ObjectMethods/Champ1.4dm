If ([DiaLogues:3]DL_Libellé:3>"")
	MESSAGES ON:C181
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=[DiaLogues:3]DL_Libellé:3)
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
Else 
	REDUCE SELECTION:C351([HeBerge:4]; 0)
End if 
FIRST RECORD:C50([HeBerge:4])
PREVIOUS RECORD:C110([HeBerge:4])
//vL_Nb_HB_F:=Enregistrements trouves([HéBergé])