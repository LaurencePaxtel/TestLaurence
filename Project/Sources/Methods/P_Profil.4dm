//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Profil
//{
//{          Vendrdi 19 Novembre 2004 à 12:22:22
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

Case of 
	: (User in group:C338(Current user:C182; <>Groupe_Externe))
		
		If ([HeberGement:5]HG_Permanencier:9=Current user:C182)
			<>vlSTR_Std:=<>vlSTR_HGEP
		Else 
			<>vlSTR_Std:=<>vlSTR_HGE
		End if 
		
	: (User in group:C338(Current user:C182; <>Groupe_Asile))
		<>vlSTR_Std:=30108
	Else 
		<>vlSTR_Std:=<>vlSTR_HG1
End case 

<>vlSTR_Std_Soc:=(<>vlSTR_Std*1000)+<>ID_Societe_Active