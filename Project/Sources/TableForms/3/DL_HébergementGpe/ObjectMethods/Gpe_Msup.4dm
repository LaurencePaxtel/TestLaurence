//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_GPmod 
//{
//{          Vendredi 27 février 2004 à 11:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (Form event code:C388=Sur clic:K2:4)
	
	If (Size of array:C274(<>te_GpCheck)>0)
		
		If (<>ta_GpClé>0)
			
			If (i_Confirmer("Supprimer le membre :"+<>va_CR+<>ta_GpClé{<>ta_GpClé}+<>va_CR+"du groupe : "+[GrouPe:36]GP_Intitulé:4))
				READ WRITE:C146([GroupeHeberges:37])
				QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_ReferenceID:1=<>tl_GpRéfi{<>ta_GpClé})
				
				If (Records in selection:C76([GroupeHeberges:37])=1)
					
					If (i_NonVerrou(->[GroupeHeberges:37]))
						DELETE RECORD:C58([GroupeHeberges:37])
						UNLOAD RECORD:C212([GroupeHeberges:37])
						
						P_Tab_GP(6; <>ta_GpClé)
					End if 
					
				End if 
				
				READ ONLY:C145([GroupeHeberges:37])
			End if 
			
		Else 
			ALERT:C41("Veuillez sélectionner un membre !")
		End if 
		
	Else 
		ALERT:C41("Aucun membre présent !")
	End if 
	
End if 