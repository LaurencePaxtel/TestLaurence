//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementReportSort
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Size of array:C274(ta_xTri)>0)
	
	If (ta_xTri>0)
		
		Case of 
			: (ta_xTri=1)  //"> Centre"
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_CentreNom:62; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)
			: (ta_xTri=2)  //"> Code postal"
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_CodePostal:14; >)
			: (ta_xTri=3)  //"< Date"
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
			: (ta_xTri=4)  //"> Nom"
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)
			: (ta_xTri=5)  //"> Numéro de fiche"
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3; >)
		End case 
		
	End if 
	
Else 
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3; >)
End if 