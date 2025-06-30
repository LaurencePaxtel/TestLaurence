//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_GPMod
//{
//{          Vendredi 27 février 2004 à 11:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


If (Form event code:C388=Sur clic:K2:4)
	
	If ([GrouPe:36]GP_ReferenceID:1>0)
		
		//NOMMER ENSEMBLE([GrouPe];"$E_temp")
		READ WRITE:C146([GrouPe:36])
		If (i_NonVerrou(->[GrouPe:36]))
			FORM SET INPUT:C55([GrouPe:36]; "GP_EcranSaisiePR")
			
			$vl_Fenetre:=i_FenêtreNo(569; 442; 4; "Groupe : modifier"; 4; "")
			MODIFY RECORD:C57([GrouPe:36]; *)
			CLOSE WINDOW:C154($vl_Fenetre)
			UNLOAD RECORD:C212([GrouPe:36])
		End if 
		READ ONLY:C145([GrouPe:36])
		//UTILISER ENSEMBLE("$E_temp")
		//    EFFACER ENSEMBLE("$E_temp")
		// vL_Nb_GP:=1
		// TRIER([GrouPe];[GrouPe]GP_Intitulé;>)
		// DEBUT SELECTION([GrouPe])
		//P_Tab_GP (3;0)
	Else 
		ALERT:C41("Veuillez sélectionner un groupe !")
	End if 
	
End if 