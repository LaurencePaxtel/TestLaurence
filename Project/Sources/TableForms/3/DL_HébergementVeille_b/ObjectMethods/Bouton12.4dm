//{==================================================}
//{ LOGICIEL : SSP :© DBsolutions
//{          Méthode :  b_DossierSIAO
//{          Vendredi 13 janvier 2012 à 12:20:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (7=7)
	P_LienDeFamille
Else 
	CREATE SET:C116([HeberGement:5]; "E_LDF_Selection")
	USE SET:C118("E_LDF_Selection")
	va_LDF_Temp:=<>va_T_Site+<>va_T_Departement+"@"
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamClé:104>""; *)
	QUERY SELECTION:C341([HeberGement:5];  & [HeberGement:5]HG_FamClé:104#va_LDF_Temp; *)
	QUERY SELECTION:C341([HeberGement:5];  & [HeberGement:5]HG_FamChef:103=True:C214)
	//UTILISER ENSEMBLE("E_LDF_Selection")
	// EFFACER ENSEMBLE("E_LDF_Selection")
	vL_NbFiches:=Records in selection:C76([HeberGement:5])
	P_HébergementVeilleSort(2)
End if 
