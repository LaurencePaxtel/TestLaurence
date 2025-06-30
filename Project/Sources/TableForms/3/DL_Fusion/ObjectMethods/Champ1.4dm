If ([DiaLogues:3]DL_LibelAutre:5>"")
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=([DiaLogues:3]DL_LibelAutre:5+"@"))
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
Else 
	REDUCE SELECTION:C351([HeBerge:4]; 0)
End if 
FIRST RECORD:C50([HeBerge:4])
PREVIOUS RECORD:C110([HeBerge:4])
vl_itemNb:=Records in selection:C76([HeBerge:4])