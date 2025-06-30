//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementProfil
//{
//{          Jeudi 10 janvier 2008 à 13:35:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284($1)
C_TEXT:C284($2)
//Mode : 115;CHRS
//Cas : Jour ou Nuit
//Permanancier

If ($1="N")  //Nuit
	<>vlSTR_Std:=30112
	<>va_TypeHGt:=""
	<>ve_Si_ModeCHRS:=1
Else   //Jour
	Case of 
		: (User in group:C338(Current user:C182; <>Groupe_Externe))
			
			If ($2=Current user:C182)
				<>vlSTR_Std:=<>vlSTR_HGEP
			Else 
				<>vlSTR_Std:=<>vlSTR_HGE
			End if 
			
		: (User in group:C338(Current user:C182; <>Groupe_Asile))
			<>vlSTR_Std:=30108
		Else 
			<>vlSTR_Std:=<>vlSTR_HG1
	End case 
	
	<>va_TypeHGt:="FAMILLE"
	<>ve_Si_ModeCHRS:=0
End if 


<>vlSTR_Std_Soc:=(<>vlSTR_Std*1000)+<>ID_Societe_Active