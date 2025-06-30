//%attributes = {}
C_DATE:C307($1)

If ($1>!00-00-00!)
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=($1-1); *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94#<>va_RepA; *)
	//4/11/2008
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
	//Fin 4/11/2008  
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
	
	MultiSoc_Filter(->[HeberGement:5])
End if 