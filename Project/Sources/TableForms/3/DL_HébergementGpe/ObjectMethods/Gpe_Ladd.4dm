//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_GPadd 
//{
//{          Mardi 17 février 2004 à 17:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Form event code:C388=Sur clic:K2:4)
	FORM SET INPUT:C55([GrouPe:36]; "GP_EcranSaisie")
	READ WRITE:C146([GrouPe:36])
	
	$vl_Fenetre:=i_FenêtreNo(519; 248; 4; "Groupe : nouveau"; 4; "")
	
	ADD RECORD:C56([GrouPe:36])  //lpc 08122017 ascenceur
	CLOSE WINDOW:C154($vl_Fenetre)
	
	READ ONLY:C145([GrouPe:36])
	
	If (OK=1)
		vL_Nb_GP:=1
		P_Tab_GP(0; 0)
		
		ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Intitulé:4; >)
		FIRST RECORD:C50([GrouPe:36])
		
		POST CLICK:C466(20; 390)
		
		If ([GrouPe:36]GP_ReferenceID:1>0)
			P_Tab_GP(4; 0)
		Else 
			P_Tab_GP(0; 0)
		End if 
		
	Else 
		ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Intitulé:4; >)
		FIRST RECORD:C50([GrouPe:36])
		
		P_Tab_GP(0; 0)
	End if 
	
End if 