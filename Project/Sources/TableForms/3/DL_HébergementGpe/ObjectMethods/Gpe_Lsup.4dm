//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_GPmod 
//{
//{          Mardi 17 février 2004 à 17:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If ([GrouPe:36]GP_ReferenceID:1>0)
	If (i_Confirmer("Supprimer le groupe : "+[GrouPe:36]GP_Intitulé:4))
		
		CREATE SET:C116([GrouPe:36]; "$E_temp")
		READ WRITE:C146([GrouPe:36])
		If (i_NonVerrou(->[GrouPe:36]))
			
			
			READ WRITE:C146([GroupeHeberges:37])
			QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
			If (Records in selection:C76([GroupeHeberges:37])>0)
				DELETE SELECTION:C66([GroupeHeberges:37])
			End if 
			READ ONLY:C145([GroupeHeberges:37])
			
			
			DELETE RECORD:C58([GrouPe:36])
			UNLOAD RECORD:C212([GrouPe:36])
			
		End if 
		READ ONLY:C145([GrouPe:36])
		
		USE SET:C118("$E_temp")
		CLEAR SET:C117("$E_temp")
		REDRAW:C174([GrouPe:36])
		
		vL_Nb_GP:=Records in selection:C76([GrouPe:36])
		// TRIER([GrouPe];[GrouPe]GP_Intitulé;>)
		// DEBUT SELECTION([GrouPe])
		P_Tab_GP(0; 0)
	End if 
Else 
	ALERT:C41("Veuillez sélectionner un groupe !")
End if 